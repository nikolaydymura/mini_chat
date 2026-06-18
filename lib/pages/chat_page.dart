import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubits/messages_cubit/messages_cubit.dart';
import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';

@RoutePage()
class ChatPage extends StatefulWidget implements AutoRouteWrapper {
  const ChatPage({required this.receiverId, super.key});

  final String receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: registry.get<MessagesCubit>()..loadMessages(receiverId),
      child: this,
    );
  }
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<File> _attachments = [];

  @override
  Widget build(BuildContext context) {
    final messagesState = context.watch<MessagesCubit>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: messagesState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: messagesState.messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messagesState.messages[index];
                      final isMine =
                          message.senderId == registry.get<UserCubit>().state.userProfile?.userId;
                      return ListTile(
                        title: Text(
                          message.content ?? '',
                          style: TextStyle(
                            fontWeight: isMine ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_attachments.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _attachments
                    .map(
                      (file) => Container(
                        padding: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Positioned.fill(child: Image.file(file, width: 64, height: 64)),
                            Align(
                              alignment: .topRight,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _attachments.remove(file);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () async {
                  final files = await ImagePicker().pickMultiImage();
                  if (files.isNotEmpty) {
                    setState(() {
                      _attachments.addAll(files.map((f) => File(f.path)));
                    });
                  }
                },
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(hintText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final message = _messageController.text.trim();
                  if (message.isNotEmpty || _attachments.isNotEmpty) {
                    context.read<MessagesCubit>().addMessage(message, [..._attachments]);
                  }
                  _messageController.clear();
                  setState(() {
                    _attachments.clear();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
