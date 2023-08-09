import 'dart:convert';

import 'package:story_app/data/model/login_response.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserEntity {
  final String userId;
  final String name;
  final String token;

  UserEntity({
    required this.userId,
    required this.name,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  UserEntity toUser(LoginResponse response) => UserEntity(
      userId: response.loginResult?.userId ?? "",
      name: response.loginResult?.name ?? "",
      token: response.loginResult?.token ?? "");

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['userId'] as String,
      name: map['name'] as String,
      token: map['token'] as String,
    );
  }

  factory UserEntity.fromJson(String source) => UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
