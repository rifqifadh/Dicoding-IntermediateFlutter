// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class RegisterResponse {
  bool? error;
  String? message;

  RegisterResponse({this.error, this.message});

  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    return RegisterResponse(
      error: map['error'] != null ? map['error'] as bool : false,
      message: map['message'] != null ? map['message'] as String : "Gagal",
    );
  }

  factory RegisterResponse.fromJson(String source) => RegisterResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
