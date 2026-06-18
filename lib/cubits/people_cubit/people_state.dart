import 'package:equatable/equatable.dart';

import '../../models/user_profile.dart';

class PeopleState extends Equatable {
  const PeopleState({
    this.users = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.searchTerm = '',
  });

  final List<UserProfile> users;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchTerm;

  PeopleState copyWith({
    List<UserProfile>? users,
    bool? isLoading,
    bool? isLoadingMore,
    String? searchTerm,
  }) {
    return PeopleState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [users, isLoading, isLoadingMore, searchTerm];
}
