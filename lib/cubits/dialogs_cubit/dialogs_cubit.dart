import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';
import '../../module/di_root.dart';
import '../user_cubit/user_cubit.dart';
import 'dialogs_state.dart';

@lazySingleton
class DialogsCubit extends Cubit<DialogsState> {
  DialogsCubit() : super(const DialogsState());

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _dialogsSubscription;

  void loadMessages() async {
    emit(state.copyWith(isLoading: true));
    _dialogsSubscription = registry
        .get<FirebaseFirestore>()
        .collection('conversations')
        .where('people_ids', arrayContains: registry.get<UserCubit>().state.userProfile?.userId)
        .snapshots()
        .listen((changes) {
          final conversations = changes.docs
              .map((doc) => {...doc.data(), 'id': doc.id})
              .map((json) => Conversation.fromJson(json))
              .toList();
          emit(state.copyWith(conversations: conversations, isLoading: false));
        });
  }

  @override
  Future<void> close() {
    _dialogsSubscription?.cancel();
    return super.close();
  }

  Future<void> updateConversation(String receiverId, Message message) async {
    final senderId = message.senderId;
    final senderProfile = registry.get<UserCubit>().state.userProfile;
    final conversation = Conversation(
      id: '',
      peopleIds: [senderId, receiverId],
      sender: senderProfile!,
      lastMessage: message,
    );

    final chatId = [senderId, receiverId].nonNulls.sorted((a, b) => a.compareTo(b)).join('_');

    await registry
        .get<FirebaseFirestore>()
        .collection('conversations')
        .doc(chatId)
        .set(conversation.toJson(), SetOptions(merge: true));
  }
}
