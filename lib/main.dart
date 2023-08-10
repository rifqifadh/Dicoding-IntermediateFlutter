
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/provider/login_provider.dart';
import 'package:story_app/provider/register_provider.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/routes/router_config.dart';

void main() {
  late ApiService apiService = ApiService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider(apiService)),
        ChangeNotifierProvider(create: (context) => LoginProvider(apiService, AuthRepository())),
        ChangeNotifierProvider(create: (context) => StoriesProvider(apiService))
      ],
      child: const StoriesApp(),
    ),
  );
}

class StoriesApp extends StatefulWidget {
  const StoriesApp({super.key});

  @override
  State<StoriesApp> createState() => _StoriesAppState();
}

class _StoriesAppState extends State<StoriesApp> {
  late MyRouteConfig myRouteConfig;

  @override
  void initState() {
    myRouteConfig = MyRouteConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Developer Stories",
      routerConfig: myRouteConfig.routerConfig,
    );
  }
}
