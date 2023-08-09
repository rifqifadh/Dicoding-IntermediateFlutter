// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponse {
  bool? error;
  String? message;
  LoginResult? loginResult;

  LoginResponse({this.error, this.message, this.loginResult});


  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      error: map['error'] != null ? map['error'] as bool : false,
      message: map['message'] != null ? map['message'] as String : "",
      loginResult: map['loginResult'] != null ? LoginResult.fromMap(map['loginResult'] as Map<String,dynamic>) : null,
    );
  }

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginResult {
  String? userId;
  String? name;
  String? token;

  LoginResult({this.userId, this.name, this.token});

  factory LoginResult.fromMap(Map<String, dynamic> map) {
    return LoginResult(
      userId: map['userId'] != null ? map['userId'] as String : "",
      name: map['name'] != null ? map['name'] as String : "",
      token: map['token'] != null ? map['token'] as String : "",
    );
  }

  factory LoginResult.fromJson(String source) => LoginResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
