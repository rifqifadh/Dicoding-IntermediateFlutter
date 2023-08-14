import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? error;
  String? message;
  LoginResult? loginResult;

  LoginResponse({this.error, this.message, this.loginResult});

  factory LoginResponse.fromJson(json) => _$LoginResponseFromJson(json);
}

@JsonSerializable()
class LoginResult {
  String? userId;
  String? name;
  String? token;

  LoginResult({this.userId, this.name, this.token});

  factory LoginResult.fromJson(json) => _$LoginResultFromJson(json);
}
