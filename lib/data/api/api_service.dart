import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:story_app/data/model/add_story.dart';
import 'package:story_app/data/model/error_response.dart';
import 'package:story_app/data/model/login_response.dart';
import 'package:story_app/data/model/parameters/login_params.dart';
import 'package:story_app/data/model/parameters/register_params.dart';
import 'package:story_app/data/model/register_response.dart';
import 'package:story_app/data/model/stories_response.dart';
import 'package:story_app/db/auth_repository.dart';

class ApiService {
  final endpoint = "https://story-api.dicoding.dev/v1";
  final AuthRepository authRepository = AuthRepository();

  Future<LoginResponse> login(LoginParams params) async {
    final response = await http.post(Uri.parse("$endpoint/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: params.toJson());

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      final message = ErrorResponse.fromJson(jsonDecode(response.body));
      throw Exception(message.message ?? "Unknonw error");
    }
  }

  Future<RegisterResponse> register(RegisterParams params) async {
    final response = await http.post(Uri.parse("$endpoint/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: params.toJson());

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      final message = ErrorResponse.fromJson(jsonDecode(response.body));
      throw Exception(message.message ?? "Unknonw error");
    }
  }

  Future<StoriesResponse> getStories({int? page = 1, int size = 10}) async {
    final user = await authRepository.getUser();
    final response = await http.get(
      Uri.parse(
        "$endpoint/stories?page=$page&size=$size",
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    if (response.statusCode == 200) {
      return StoriesResponse.fromJson(jsonDecode(response.body));
    } else {
      final message = ErrorResponse.fromJson(jsonDecode(response.body));
      throw Exception(message.message ?? "Unknonw error");
    }
  }

  Future<UploadResponse> uploadFile(
    List<int> bytes,
    String fileName,
    String description,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse("$endpoint/stories"));
    final user = await authRepository.getUser();
    final multiPartFile =
        http.MultipartFile.fromBytes("photo", bytes, filename: fileName);
    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer ${user?.token}'
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final UploadResponse uploadResponse = UploadResponse.fromJson(
        responseData,
      );
      return uploadResponse;
    } else {
      throw Exception("Upload file error");
    }
  }
}
