import 'package:equatable/equatable.dart';

import '../../models/message.dart';

class MessagesState extends Equatable {
  const MessagesState({this.messages = const [], this.isLoading = false});
  final List<Message> messages;
  final bool isLoading;

  MessagesState copyWith({List<Message>? messages, bool? isLoading}) {
    return MessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading];
}
