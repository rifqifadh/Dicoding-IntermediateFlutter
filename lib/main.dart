import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/provider/register_provider.dart';
import 'package:story_app/routes/router_config.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider(ApiService()))
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
