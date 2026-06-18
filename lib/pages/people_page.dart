import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/people_cubit/people_cubit.dart';
import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';

@RoutePage()
class PeoplePage extends StatefulWidget implements AutoRouteWrapper {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(value: registry.get<PeopleCubit>(), child: this);
  }
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<PeopleCubit>().searchUsers(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final peopleState = context.watch<PeopleCubit>().state;
    final itemsCount = peopleState.isLoadingMore
        ? peopleState.users.length + 1
        : peopleState.users.length;
    final isLoading = peopleState.isLoading && peopleState.users.isEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(hintText: 'Type to start search...'),
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : ListView.builder(
                      itemCount: itemsCount,
                      itemBuilder: (context, index) {
                        if (index >= peopleState.users.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator.adaptive()),
                          );
                        }
                        final user = peopleState.users[index];
                        return ListTile(
                          onTap: () {
                            final currentUserId = registry
                                .get<UserCubit>()
                                .state
                                .userProfile
                                ?.userId;
                            if (currentUserId == user.userId) return;
                            context.pop(user.userId);
                          },
                          title: Text(
                            user.firstName ?? 'Unknown',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(user.lastName ?? 'Unknown'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
