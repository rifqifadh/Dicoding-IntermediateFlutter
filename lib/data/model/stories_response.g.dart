// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoriesResponse _$StoriesResponseFromJson(Map<String, dynamic> json) =>
    StoriesResponse(
      error: json['error'] as bool,
      message: json['message'] as String?,
      listStory:
          (json['listStory'] as List<dynamic>?)?.map(Story.fromJson).toList(),
    );
