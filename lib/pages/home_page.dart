import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/dialogs_cubit/dialogs_cubit.dart';
import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';
import '../navigation/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: registry.get<UserCubit>()),
        BlocProvider.value(value: registry.get<DialogsCubit>()..loadMessages()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogsState = context.watch<DialogsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.pushRoute(UserProfileRoute());
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: dialogsState.isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: dialogsState.conversations.length,
                    itemBuilder: (context, index) {
                      final message = dialogsState.conversations[index];

                      return ListTile(
                        title: Text(message.lastMessage.content ?? ''),
                        onTap: () {
                          final currentUserId = registry
                              .get<UserCubit>()
                              .state
                              .userProfile
                              ?.userId;
                          final otherUserId = message.peopleIds
                              .where((id) => id != currentUserId)
                              .first;
                          context.pushRoute(ChatRoute(receiverId: otherUserId));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(
            ChatRoute(receiverId: 'prp5BP2cyResnc0nWxAJuJDXjXl1'),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
