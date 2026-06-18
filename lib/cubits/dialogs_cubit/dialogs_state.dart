import 'package:equatable/equatable.dart';

import '../../models/conversation.dart';

class DialogsState extends Equatable {
  const DialogsState({this.conversations = const [], this.isLoading = false});
  final List<Conversation> conversations;
  final bool isLoading;

  DialogsState copyWith({List<Conversation>? conversations, bool? isLoading}) {
    return DialogsState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [conversations, isLoading];
}
