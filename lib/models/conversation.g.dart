// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
  id: json['id'] as String,
  recipient: UserProfile.fromJson(json['recipient'] as Map<String, dynamic>),
  sender: UserProfile.fromJson(json['sender'] as Map<String, dynamic>),
  lastMessage: Message.fromJson(json['last_message'] as Map<String, dynamic>),
  peopleIds: (json['peoples_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'peoples_ids': instance.peopleIds,
      'recipient': instance.recipient.toJson(),
      'sender': instance.sender.toJson(),
      'last_message': instance.lastMessage.toJson(),
    };
