// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';

import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/stories_response.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;

  StoriesProvider(this.apiService);

  bool isLoading = false;
  String message = "";
  StoriesResponse? stories;

  Future<void> fetchStories() async {
    try {
      message = "";
      stories = null;
      isLoading = true;
      notifyListeners();

      stories = await apiService.getStories();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      // print(e.toString());
      isLoading = false;
      message = e.toString();
      notifyListeners();
    }
  }
}
