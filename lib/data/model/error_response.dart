import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  final bool? error;
  final String? message;
  
  ErrorResponse({
    this.error,
    this.message,
  });

  factory ErrorResponse.fromJson(json) => _$ErrorResponseFromJson(json);
}
