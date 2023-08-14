import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
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

  factory RegisterResponse.fromJson(json) => _$RegisterResponseFromJson(json);
}
