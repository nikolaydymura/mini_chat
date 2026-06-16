import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../models/message.dart';
import '../../module/di_root.dart';
import '../dialogs_cubit/dialogs_cubit.dart';
import '../user_cubit/user_cubit.dart';
import 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(const MessagesState());
  late final String receiverId;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;

  late final chatId = [
    registry.get<UserCubit>().state.userProfile?.userId,
    receiverId,
  ].nonNulls.sorted((a, b) => a.compareTo(b)).join('_');

  void loadMessages(String receiverId) {
    this.receiverId = receiverId;
    emit(state.copyWith(isLoading: true));

    _messagesSubscription = registry
        .get<FirebaseFirestore>()
        .collection('conversations')
        .doc(chatId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .limit(10)
        .snapshots()
        .listen((change) {
          final documents = change.docs;
          final messages = documents
              .map((doc) => Message.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
          emit(state.copyWith(messages: messages, isLoading: false));
        });
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }

  void addMessage(String? content, List<File>? attachments) async {
    final senderId = registry.get<UserCubit>().state.userProfile?.userId;
    final uploadedAttachments = await uploadAttachments(attachments);
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      senderId: senderId!,
      attachments: uploadedAttachments,
      createdAt: DateTime.now(),
    );
    await registry
        .get<FirebaseFirestore>()
        .collection('conversations')
        .doc(chatId)
        .collection('messages')
        .add({
          ...newMessage.toJson(),
          'delivered_at': FieldValue.serverTimestamp(),
        });
    await registry.get<DialogsCubit>().updateConversation(
      'prp5BP2cyResnc0nWxAJuJDXjXl1',
      newMessage,
    );
  }

  Future<List<Attachment>?> uploadAttachments(List<File>? attachments) async {
    if (attachments == null || attachments.isEmpty) return null;
    final storage = registry.get<FirebaseStorage>();
    final uploadedAttachments = <Attachment>[];

    for (final file in attachments) {
      final id = Uuid().v4();
      final ref = storage.ref('messagesAttachments').child(id);
      await ref.putFile(file);
      final url =
          'https://firebasestorage.googleapis.com/v0/b/first-one-9d7d3.appspot.com/o/messagesAttachments%2F$id?alt=media';
      uploadedAttachments.add(Attachment(id: id, url: url, type: 'image'));
    }

    return uploadedAttachments;
  }
}
