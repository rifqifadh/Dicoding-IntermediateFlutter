// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      loginResult: json['loginResult'] == null
          ? null
          : LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
    );

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      token: json['token'] as String?,
    );
