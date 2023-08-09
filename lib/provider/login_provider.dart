import 'package:flutter/material.dart';

import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/login_response.dart';
import 'package:story_app/data/model/parameters/login_params.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/db/user_entity.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;
  final AuthRepository authRepository;

  LoginProvider(this.apiService, this.authRepository);

  bool isLoading = false;
  String message = "";
  LoginResponse? response;

  Future<bool> doLogin(LoginParams params) async {
    try {
      message = "";
      response = null;
      isLoading = true;
      notifyListeners();

      response = await apiService.login(params);
      if (response?.loginResult != null) {
        final result = response?.loginResult;
        authRepository.saveUser(
          UserEntity(
            name: result?.name ?? "",
            userId: result?.userId ?? "",
            token: result?.token ?? "",
          ),
        );
      }
      isLoading = false;

      notifyListeners();

      return true;
    } catch (e) {
      isLoading = false;
      message = e.toString();
      notifyListeners();

      return false;
    }
  }
}
