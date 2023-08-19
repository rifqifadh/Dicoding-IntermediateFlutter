import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final num? lat;
  final num? lon;
  
  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory Story.fromJson(json) => _$StoryFromJson(json);
}
