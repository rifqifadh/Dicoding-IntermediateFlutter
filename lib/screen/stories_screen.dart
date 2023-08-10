import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/widget/story_widget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {

  final AuthRepository authRepository = AuthRepository();

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
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                final loggedOut = await authRepository.logout();
                if (loggedOut && context.mounted) {
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
              return StoryWidget(story: stories[index]);
            },
          );
        },
      ),
      // floatingActionButton: ,
    );
  }

  fetchStories() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<StoriesProvider>(context, listen: false).fetchStories();
      context.read<StoriesProvider>().fetchStories();
    });
  }
}
