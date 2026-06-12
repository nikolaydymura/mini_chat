import 'package:equatable/equatable.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';

class DialogsState extends Equatable {
  final List<Conversation> conversations;
  final bool isLoading;

  const DialogsState({this.conversations = const [], this.isLoading = false});

  DialogsState copyWith({List<Conversation>? conversations, bool? isLoading}) {
    return DialogsState(
      conversations: conversations ?? this.conversations,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [conversations, isLoading];
}
