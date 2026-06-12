import 'package:equatable/equatable.dart';

import '../../models/message.dart';

class MessagesState extends Equatable {
  final List<Message> messages;
  final bool isLoading;

  const MessagesState({this.messages = const [], this.isLoading = false});

  MessagesState copyWith({List<Message>? messages, bool? isLoading}) {
    return MessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading];
}
