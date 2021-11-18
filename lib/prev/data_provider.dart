

import 'package:flutter/cupertino.dart';
import 'package:test_app_firebase/db_firebase/database.dart';
import 'package:test_app_firebase/model/data_model.dart';

class DataProvider with ChangeNotifier {
  List<DataModel> list = [];

  Database db;

  DataProvider(Database _db){
    db=_db;
    getData(_db);
  }


  Future<void> getData(Database db) async {
    try{
      list = await db.read();
      print("provider data #####=> " + list.toString());
      notifyListeners();
    } catch (e) {
      print("provider error #####=> " + e.toString());
    }
  }


  Future<void> addPost(DataModel _dataModel) async {
    try{
      await db.create(_dataModel);
      print("provider data #####=> " + list.toString());
      getData(db);
    } catch (e) {
      print("provider error #####=> " + e.toString());
    }
  }



}