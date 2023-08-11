// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:story_app/db/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  bool isLoggedIn = false;
  bool isInHome = false;
  // bool isRegister = false;
  // String? rootPath;

  AuthProvider({
    required this.authRepository,
  });

  Future<void> getAuthStatus() async {
    isLoggedIn = await authRepository.isLoggedIn();
  }

  Future<void> successLogin() async {
    isInHome = true;
  }

  Future<bool> logout() async {
    // rootPath = '/login';
    isInHome = false;
    return authRepository.logout();
  }
}
