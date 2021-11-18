import 'package:flutter/material.dart';
import 'package:test_app_firebase/db_firebase/database.dart';
import 'package:test_app_firebase/prev/login_prev.dart';

class LoginProvider extends ChangeNotifier {
  LoginPreferences loginPreferences = LoginPreferences();

  LoginProvider(){
    getLogin();
  }


  Future<void> getLogin() async {
    login  = await  loginPreferences.getLogin();
    notifyListeners();
  }


  bool login = true;


   void putLogin(bool value) {
    login = value;
    loginPreferences.setLogin(value);
    notifyListeners();
  }


  Future<void> addUser(Database db,String name,String pass) async {
    try{
     await db.createUser(name, pass);
      print("provider user added  #####=> " + name);
      loginPreferences.setLogin(true);
      // notifyListeners();
    } catch (e) {
      print("provider error #####=> " + e.toString());
    }
  }


}
