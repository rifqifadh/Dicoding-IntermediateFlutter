// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:story_app/data/model/story_model.dart';

class StoryResponse {
  final bool error;
  final String? message;
  final Story? story;
  
  StoryResponse({
    required this.error,
    this.message,
    this.story,
  });

  factory StoryResponse.fromMap(Map<String, dynamic> map) {
    return StoryResponse(
      error: map['error'] as bool,
      message: map['message'] != null ? map['message'] as String : "",
      story: map['story'] != null ? Story.fromMap(map['story'] as Map<String,dynamic>) : null,
    );
  }

  factory StoryResponse.fromJson(String source) => StoryResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
