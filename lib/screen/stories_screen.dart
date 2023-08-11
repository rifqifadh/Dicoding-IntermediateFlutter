import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/widget/story_widget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  bool isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Stories"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                final provider = context.read<AuthProvider>();
                final isLoggedOut = await provider.logout();
                if (isLoggedOut && context.mounted) {
                  context.go('/login');
                }
              },
              child: const Icon(
                Icons.logout,
                size: 26,
              ),
            ),
          )
        ],
      ),
      body: Consumer<StoriesProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final stories = value.stories?.listStory ?? [];
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return InkWell(child:  StoryWidget(story: stories[index]), onTap: () {
                context.push('/detail', extra: stories[index]);
              },);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool success = await context.push<bool>("/add-story") ?? false;
          
          if(success == true && context.mounted) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<StoriesProvider>().fetchStories();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  fetchStories() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StoriesProvider>().fetchStories();
    });
  }
}
