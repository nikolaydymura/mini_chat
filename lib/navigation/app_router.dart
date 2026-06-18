import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../cubits/user_cubit/user_cubit.dart';
import '../module/di_root.dart';
import 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  late final reevaluateListener = ValueNotifier(0);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page, initial: true, guards: [_AuthGuard()]),
    AutoRoute(page: UserProfileRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: PeopleRoute.page),
  ];

  void logout() {
    reevaluateListener.value++;
  }
}

class _AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = registry.get<UserCubit>().state.isAuthenticated;

    if (isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirectUntil(
        LoginRoute(
          onContinue: () {
            resolver.next(true);
          },
        ),
      );
    }
  }
}
