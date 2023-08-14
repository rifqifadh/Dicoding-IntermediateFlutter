// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/loading_state.dart';
import 'package:story_app/data/model/story_model.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;

  StoriesProvider(this.apiService);

  // String message = "";
  List<Story> stories = [];
  int? page = 1;
  int size = 10;
  LoadingState storiesState = const LoadingState.initial();

  Future<void> fetchStories() async {
    try {
      if (page == 1) {
        storiesState = const LoadingState.loading();
      }
      notifyListeners();

      final result = await apiService.getStories(page: page, size: size);
      stories.addAll(result.listStory ?? []);
      storiesState = const LoadingState.loaded();
      if (result.listStory!.length < size) {
        page = null;
      } else {
        page = page! + 1;
      }

      notifyListeners();
    } catch (e) {
      storiesState = LoadingState.error(e.toString());
      notifyListeners();
    }
  }
}
