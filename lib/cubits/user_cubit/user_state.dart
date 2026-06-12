import 'package:equatable/equatable.dart';

import '../../models/user_profile.dart';

class UserState extends Equatable {
  final bool isAuthenticated;
  final UserProfile? userProfile;

  const UserState({
    this.isAuthenticated = false,
    this.userProfile,
  });

  UserState copyWith({
    bool? isAuthenticated,
    UserProfile? userProfile,
  }) {
    return UserState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, userProfile];
}
