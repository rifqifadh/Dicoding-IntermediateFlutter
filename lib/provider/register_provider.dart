import 'package:flutter/cupertino.dart';

import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/data/model/parameters/register_params.dart';
import 'package:story_app/data/model/register_response.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  RegisterProvider(this.apiService);

  bool isLoading = false;
  String message = "";
  RegisterResponse? registerResponse;

  Future<bool> register(RegisterParams params) async {
    try {
      message = "";
      registerResponse = null;
      isLoading = true;
      notifyListeners();

      registerResponse = await apiService.register(params);
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
