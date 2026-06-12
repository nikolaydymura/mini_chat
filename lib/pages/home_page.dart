import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';
import '../navigation/app_router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider.value(value: registry.get<UserCubit>())],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(ChatRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
