// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/screen/login_screen.dart';
import 'package:story_app/screen/register_screen.dart';
import 'package:story_app/screen/stories_screen.dart';

class MyRouteConfig {
  late bool isLoggedIn = false;

  MyRouteConfig() {
    _init();
  }

  _init() async {
    isLoggedIn = await AuthRepository().isLoggedIn();
  }

  late GoRouter routerConfig = GoRouter(
    initialLocation: isLoggedIn ? "/" : "/login",
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return const StoriesScreen();
        },
      ),
      GoRoute(
        path: "/login",
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: "/register",
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
    ],
  );
}
