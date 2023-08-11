// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/model/story_model.dart';

import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/screen/add_story.dart';
import 'package:story_app/screen/login_screen.dart';
import 'package:story_app/screen/register_screen.dart';
import 'package:story_app/screen/stories_screen.dart';
import 'package:story_app/screen/story_screen.dart';

class MyRouteConfig {
  late bool isInHome = false;

  late GoRouter routerConfig = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      final provider = context.read<AuthProvider>();
      await provider.getAuthStatus();
      final loggedIn = provider.isLoggedIn;
      if (loggedIn) {
        if (state.uri.toString() == '/') isInHome = true;
        return isInHome ? null : '/';
      }

      return null;
    },
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
      GoRoute(
        path: "/add-story",
        builder: (BuildContext context, GoRouterState state) {
          return const AddStoryScreen();
        },
      ),
      GoRoute(
        path: "/detail",
        builder: (context, state) {
          // final query = state.uri.queryParameters['id'];
          return StoryScreen(story: state.extra as Story);
        },
      )
    ],
  );
}
