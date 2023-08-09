import 'package:http/http.dart' as http;
import 'package:story_app/data/model/login_response.dart';
import 'package:story_app/data/model/parameters/login_params.dart';
import 'package:story_app/data/model/parameters/register_params.dart';
import 'package:story_app/data/model/register_response.dart';

class ApiService {
  final endpoint = "https://story-api.dicoding.dev/v1";

  Future<LoginResponse> login(LoginParams params) async {
    final response = await http.post(
      Uri.parse("$endpoint/login"),
      body: params.toJson()
      );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.body);
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<RegisterResponse> register(RegisterParams params) async {
    final response = await http.post(
      Uri.parse("$endpoint/login"),
      body: params.toJson()
      );

    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(response.body);
    } else {
      throw Exception("Failed to login");
    }
  }
}