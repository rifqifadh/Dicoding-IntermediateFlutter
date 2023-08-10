import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/widget/story_widget.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Developer Stories")),
        body: Consumer<StoriesProvider>(
          builder: (context, value, child) {
            // print(value.stories);
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
        ));
  }

  fetchStories() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<StoriesProvider>(context, listen: false).fetchStories();
      context.read<StoriesProvider>().fetchStories();
    });
  }
}
