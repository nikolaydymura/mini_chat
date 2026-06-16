// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:mini_chat/pages/chat_page.dart' as _i1;
import 'package:mini_chat/pages/home_page.dart' as _i2;
import 'package:mini_chat/pages/login_page.dart' as _i3;
import 'package:mini_chat/pages/user_profile_page.dart' as _i4;

/// generated route for
/// [_i1.ChatPage]
class ChatRoute extends _i5.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i6.Key? key,
    required String receiverId,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, receiverId: receiverId),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i5.WrappedRoute(
        child: _i1.ChatPage(key: args.key, receiverId: args.receiverId),
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.receiverId});

  final _i6.Key? key;

  final String receiverId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, receiverId: $receiverId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key && receiverId == other.receiverId;
  }

  @override
  int get hashCode => key.hashCode ^ receiverId.hashCode;
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i2.HomePage());
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i6.Key? key,
    required _i6.VoidCallback onContinue,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onContinue: onContinue),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>();
      return _i5.WrappedRoute(
        child: _i3.LoginPage(key: args.key, onContinue: args.onContinue),
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, required this.onContinue});

  final _i6.Key? key;

  final _i6.VoidCallback onContinue;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onContinue: $onContinue}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key && onContinue == other.onContinue;
  }

  @override
  int get hashCode => key.hashCode ^ onContinue.hashCode;
}

/// generated route for
/// [_i4.UserProfilePage]
class UserProfileRoute extends _i5.PageRouteInfo<void> {
  const UserProfileRoute({List<_i5.PageRouteInfo>? children})
    : super(UserProfileRoute.name, initialChildren: children);

  static const String name = 'UserProfileRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i4.UserProfilePage());
    },
  );
}
