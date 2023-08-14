import 'package:json_annotation/json_annotation.dart';
import 'package:story_app/data/model/story_model.dart';

part 'stories_response.g.dart';

@JsonSerializable()
class StoriesResponse {
  final bool error;
  final String? message;
  final List<Story>? listStory;

  StoriesResponse({
    required this.error,
    this.message,
    this.listStory,
  });

  factory StoriesResponse.fromJson(Map<String, dynamic> json) => _$StoriesResponseFromJson(json);
}
