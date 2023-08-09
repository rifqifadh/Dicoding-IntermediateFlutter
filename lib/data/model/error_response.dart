import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ErrorResponse {
  final bool? error;
  final String? message;
  
  ErrorResponse({
    this.error,
    this.message,
  });

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      error: map['error'] != null ? map['error'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
