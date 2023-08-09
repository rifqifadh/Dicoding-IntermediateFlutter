import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
