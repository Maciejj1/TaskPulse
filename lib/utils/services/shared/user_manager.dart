import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  String userToken = "";

  Future<void> init() async {
    userToken = await getUID() ?? "";
  }

  Future<void> setUID(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    userToken = token;
  }

  Future<String?> getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    userToken = "";
  }
}
