// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
  id: json['id'] as String,
  recipientId: json['recipient_id'] as String,
  recipient: UserProfile.fromJson(json['recipient'] as Map<String, dynamic>),
  senderId: json['sender_id'] as String,
  sender: UserProfile.fromJson(json['sender'] as Map<String, dynamic>),
  lastMessage: Message.fromJson(json['last_message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'recipient_id': instance.recipientId,
      'recipient': instance.recipient.toJson(),
      'sender_id': instance.senderId,
      'sender': instance.sender.toJson(),
      'last_message': instance.lastMessage.toJson(),
    };
