// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:story_app/data/model/story_model.dart';

class StoriesResponse {
  final bool error;
  final String? message;
  final List<Story>? listStory;

  StoriesResponse({
    required this.error,
    this.message,
    this.listStory,
  });

  factory StoriesResponse.fromMap(Map<String, dynamic> map) {
    return StoriesResponse(
      error: map['error'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      listStory: map['listStory'] != null ? List<Story>.from((map['listStory'] as List<dynamic>).map<Story?>((x) => Story.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  factory StoriesResponse.fromJson(String source) => StoriesResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
