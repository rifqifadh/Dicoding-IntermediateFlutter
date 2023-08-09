
import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer Stories")),
      body: const Text("Stories"),
    );
  }
}