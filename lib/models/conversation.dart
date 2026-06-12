import 'package:json_annotation/json_annotation.dart';

import 'message.dart';
import 'user_profile.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true)
class Conversation {
  @JsonKey(name: 'id', includeToJson: false)
  final String id;
  @JsonKey(name: 'recipient_id')
  final String recipientId;
  @JsonKey(name: 'recipient')
  final UserProfile recipient;
  @JsonKey(name: 'sender_id')
  final String senderId;
  @JsonKey(name: 'sender')
  final UserProfile sender;
  @JsonKey(name: 'last_message')
  final Message lastMessage;

  Conversation({
    required this.id,
    required this.recipientId,
    required this.recipient,
    required this.senderId,
    required this.sender,
    required this.lastMessage,
  });

  Conversation copyWith({
    String? id,
    String? recipientId,
    UserProfile? recipient,
    String? senderId,
    UserProfile? sender,
    Message? lastMessage,
  }) {
    return Conversation(
      id: id ?? this.id,
      recipientId: recipientId ?? this.recipientId,
      recipient: recipient ?? this.recipient,
      senderId: senderId ?? this.senderId,
      sender: sender ?? this.sender,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
