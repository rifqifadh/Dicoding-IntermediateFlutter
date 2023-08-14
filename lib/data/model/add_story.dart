import 'package:json_annotation/json_annotation.dart';

part 'add_story.g.dart';

@JsonSerializable()
class UploadResponse {
  final bool error;
  final String message;

  UploadResponse({
    required this.error,
    required this.message,
  });

  factory UploadResponse.fromJson(json) => _$UploadResponseFromJson(json);
}