

import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier{
  bool loading = false;

  void setLoad(bool value){
    loading = value;
    notifyListeners();
  }


}