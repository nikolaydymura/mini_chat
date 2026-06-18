// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:mini_chat/pages/chat_page.dart' as _i1;
import 'package:mini_chat/pages/home_page.dart' as _i2;
import 'package:mini_chat/pages/login_page.dart' as _i3;
import 'package:mini_chat/pages/people_page.dart' as _i4;
import 'package:mini_chat/pages/user_profile_page.dart' as _i5;

/// generated route for
/// [_i1.ChatPage]
class ChatRoute extends _i6.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required String receiverId,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(receiverId: receiverId, key: key),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i6.WrappedRoute(
        child: _i1.ChatPage(receiverId: args.receiverId, key: args.key),
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({required this.receiverId, this.key});

  final String receiverId;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{receiverId: $receiverId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return receiverId == other.receiverId && key == other.key;
  }

  @override
  int get hashCode => receiverId.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i6.WrappedRoute(child: const _i2.HomePage());
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    required _i7.VoidCallback onContinue,
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(onContinue: onContinue, key: key),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i6.WrappedRoute(
        child: _i3.LoginPage(onContinue: args.onContinue, key: args.key),
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({required this.onContinue, this.key});

  final _i7.VoidCallback onContinue;

  final _i7.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{onContinue: $onContinue, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return onContinue == other.onContinue && key == other.key;
  }

  @override
  int get hashCode => onContinue.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i4.PeoplePage]
class PeopleRoute extends _i6.PageRouteInfo<void> {
  const PeopleRoute({List<_i6.PageRouteInfo>? children})
    : super(PeopleRoute.name, initialChildren: children);

  static const String name = 'PeopleRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i6.WrappedRoute(child: const _i4.PeoplePage());
    },
  );
}

/// generated route for
/// [_i5.UserProfilePage]
class UserProfileRoute extends _i6.PageRouteInfo<void> {
  const UserProfileRoute({List<_i6.PageRouteInfo>? children})
    : super(UserProfileRoute.name, initialChildren: children);

  static const String name = 'UserProfileRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return _i6.WrappedRoute(child: const _i5.UserProfilePage());
    },
  );
}
