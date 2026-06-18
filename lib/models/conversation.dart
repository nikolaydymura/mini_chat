import 'package:json_annotation/json_annotation.dart';

import 'message.dart';
import 'user_profile.dart';

part 'conversation.g.dart';

@JsonSerializable(explicitToJson: true)
class Conversation {
  Conversation({
    required this.id,
    required this.sender,
    required this.lastMessage,
    required this.peopleIds,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  @JsonKey(name: 'id', includeToJson: false)
  final String id;
  @JsonKey(name: 'peoples_ids')
  final List<String> peopleIds;
  @JsonKey(name: 'sender')
  final UserProfile sender;
  @JsonKey(name: 'last_message')
  final Message lastMessage;

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
