

import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {
  static const loginState = "loginState";

  setLogin(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(loginState, value);
  }

  Future<bool> getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loginState) ?? false;
  }


}