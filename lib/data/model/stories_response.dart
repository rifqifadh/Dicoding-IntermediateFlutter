// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:story_app/data/model/story_response.dart';

class StoriesResponse {
  final bool error;
  final String? message;
  final List<StoryResponse>? listStory;

  StoriesResponse({
    required this.error,
    this.message,
    this.listStory,
  });

  factory StoriesResponse.fromMap(Map<String, dynamic> map) {
    return StoriesResponse(
      error: map['error'] as bool,
      message: map['message'] != null ? map['message'] as String : "",
      listStory: map['listStory'] != null
          ? List<StoryResponse>.from(
              (map['listStory'] as List<int>).map<StoryResponse?>(
                (x) => StoryResponse.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  factory StoriesResponse.fromJson(String source) =>
      StoriesResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
