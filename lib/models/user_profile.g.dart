// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  photoUrl: json['photo_url'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'date_of_birth': instance.dateOfBirth?.toIso8601String(),
  'photo_url': instance.photoUrl,
};
