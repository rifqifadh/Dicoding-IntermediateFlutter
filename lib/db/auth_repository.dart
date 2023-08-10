import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/db/user_entity.dart';

class AuthRepository {
  final String stateKey = "state";

  Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await SharedPreferences.getInstance();
    final isLoggedOut = await preferences.setBool(stateKey, false);
    final isUserDeleted = await deleteUser();
    return isLoggedOut && isUserDeleted;
  }

  /// todo 4: add user manager to handle user information like email and password
  final String userKey = "user";

  Future<bool> saveUser(UserEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.setString(userKey, user.toJson());
  }

  Future<bool> deleteUser() async {
    final preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    return preferences.setString(userKey, "");
  }

  Future<UserEntity?> getUser() async {
    final preferences = await SharedPreferences.getInstance();
    final json = preferences.getString(userKey) ?? "";
    UserEntity? user;
    try {
      user = UserEntity.fromJson(json);
    } catch (e) {
      user = null;
    }
    return user;
  }
  
}
