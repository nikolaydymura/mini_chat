// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String? ?? '',
  content: json['content'] as String?,
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  senderId: json['sender_id'] as String,
  createdAt: FirestoreModelUtils.fromTimestamp(
    json['created_at'] as Timestamp?,
  ),
  deliveredAt: FirestoreModelUtils.fromTimestamp(
    json['delivered_at'] as Timestamp?,
  ),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'content': instance.content,
  'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
  'sender_id': instance.senderId,
  'created_at': FirestoreModelUtils.toTimestamp(instance.createdAt),
  'delivered_at': FirestoreModelUtils.toTimestamp(instance.deliveredAt),
};

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
  id: json['id'] as String,
  url: json['url'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'type': instance.type,
    };
