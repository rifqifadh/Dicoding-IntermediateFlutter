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
  final ScrollController scrollController = ScrollController();
  bool isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    final provider = context.read<StoriesProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.page != null) {
          fetchStories();
        }
      }
    });
    Future.microtask(() async => fetchStories());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
          final state = value.storiesState;
          return state.map(initial: (value) {
            return const Center(
              child: Text("No data"),
            );
          }, loading: (value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, loaded: (valueCase) {
            final stories = value.stories;
            return ListView.builder(
              controller: scrollController,
              itemCount: stories.length + (value.page != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == stories.length  && value.page != null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return InkWell(
                  child: StoryWidget(story: stories[index]),
                  onTap: () {
                    context.push('/detail', extra: stories[index]);
                  },
                );
              },
            );
          }, error: (value) {
            final message = value.message;
            return Center(
              child: Text(message),
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ScaffoldMessengerState scaffoldMessengerState =
              ScaffoldMessenger.of(context);
          final bool? success = await context.push<bool>("/add-story");
          if (success == true) {
            scaffoldMessengerState.showSnackBar(
                const SnackBar(content: Text('Sukses menambahkan story')));
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<StoriesProvider>().refreshStories();
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
