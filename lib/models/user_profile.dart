import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends Equatable {
  const UserProfile({this.userId, this.firstName, this.lastName, this.dateOfBirth, this.photoUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  @JsonKey(name: 'user_id', includeFromJson: false, includeToJson: false)
  final String? userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'date_of_birth')
  final DateTime? dateOfBirth;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object?> get props => [userId, firstName, lastName, dateOfBirth, photoUrl];

  UserProfile copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? photoUrl,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
