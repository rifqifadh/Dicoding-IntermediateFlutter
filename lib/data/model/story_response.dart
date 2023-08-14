import 'package:story_app/data/model/story_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse {
  final bool error;
  final String? message;
  final Story? story;
  
  StoryResponse({
    required this.error,
    this.message,
    this.story,
  });

  factory StoryResponse.fromJson(json) => _$StoryResponseFromJson(json);
}
