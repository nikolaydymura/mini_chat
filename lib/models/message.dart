import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'firestore_model_utils.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  @JsonKey(name: 'id', includeToJson: false, defaultValue: '')
  final String id;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'attachments')
  final List<Attachment>? attachments;
  @JsonKey(name: 'sender_id')
  final String senderId;
  @JsonKey(
    name: 'created_at',
    fromJson: FirestoreModelUtils.fromTimestamp,
    toJson: FirestoreModelUtils.toTimestamp,
  )
  final DateTime? createdAt;
  @JsonKey(
    name: 'delivered_at',
    fromJson: FirestoreModelUtils.fromTimestamp,
    toJson: FirestoreModelUtils.toTimestamp,
  )
  final DateTime? deliveredAt;

  Message({
    required this.id,
    this.content,
    this.attachments,
    required this.senderId,
    required this.createdAt,
    this.deliveredAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Attachment {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'type')
  final String type;

  Attachment({required this.id, required this.url, required this.type});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
