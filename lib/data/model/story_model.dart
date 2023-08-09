// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Story {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  
  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      photoUrl: map['photoUrl'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source) as Map<String, dynamic>);
}
