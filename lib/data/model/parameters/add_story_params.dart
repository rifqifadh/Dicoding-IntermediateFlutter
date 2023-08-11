import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class AddStoryParams {
    String fileName;
    String description;

  AddStoryParams({
    required this.fileName,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'description': description,
    };
  }

  factory AddStoryParams.fromMap(Map<String, dynamic> map) {
    return AddStoryParams(
      fileName: map['fileName'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStoryParams.fromJson(String source) => AddStoryParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
