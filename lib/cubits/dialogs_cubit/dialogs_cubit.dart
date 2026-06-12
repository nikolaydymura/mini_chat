import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';
import '../../models/user_profile.dart';
import '../../module/di_root.dart';
import '../user_cubit/user_cubit.dart';
import 'dialogs_state.dart';

@lazySingleton
class DialogsCubit extends Cubit<DialogsState> {
  DialogsCubit() : super(const DialogsState());

  Future<void> loadMessages() async {
    emit(state.copyWith(isLoading: true));
    final loadedMessages = await registry
        .get<FirebaseFirestore>()
        .collection('conversations')
        .where(
          'senser_id',
          isEqualTo: registry.get<UserCubit>().state.userProfile?.userId,
        )
        .get();
    final conversations = loadedMessages.docs
        .map((doc) => {...doc.data(), 'id': doc.id})
        .map((json) => Conversation.fromJson(json))
        .toList();
    emit(state.copyWith(conversations: conversations, isLoading: false));
  }

  Future<void> updateConversation(Message message) async {
    final senderId = message.senderId;
    final receiverId = message.receiverId;
    final senderProfile = registry.get<UserCubit>().state.userProfile;
    final receiverProfile = await registry
        .get<FirebaseFirestore>()
        .collection('profiles')
        .doc(receiverId)
        .get();
    final receiver = UserProfile.fromJson({
      ...?receiverProfile.data(),
      'user_id': receiverProfile.id,
    });
    final conversation =
        state.conversations
            .where((e) => e.recipientId == receiverId)
            .where((e) => e.senderId == senderId)
            .firstOrNull ??
        Conversation(
          id: '',
          recipientId: receiverId,
          recipient: receiver,
          senderId: senderId,
          sender: senderProfile!,
          lastMessage: message,
        );
    final updatedConversation = conversation.copyWith(lastMessage: message);

    if (updatedConversation.id.isNotEmpty) {
      await registry
          .get<FirebaseFirestore>()
          .collection('conversations')
          .doc(updatedConversation.id)
          .update(updatedConversation.toJson());
      emit(
        state.copyWith(
          conversations: [
            ...state.conversations.where((e) => e.id != updatedConversation.id),
            updatedConversation,
          ],
        ),
      );
    } else {
      final doc = await registry
          .get<FirebaseFirestore>()
          .collection('conversations')
          .add(updatedConversation.toJson());
      final conversationDoc = await doc.get();
      final serverConversation = Conversation.fromJson({
        ...?conversationDoc.data(),
        'id': conversationDoc.id,
      });
      emit(
        state.copyWith(
          conversations: [...state.conversations, serverConversation],
        ),
      );
    }
  }
}
