import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_firebase/db_firebase/database.dart';
import 'package:test_app_firebase/provider/loading_provider.dart';
import 'package:test_app_firebase/provider/login_provider.dart';

import 'main.dart';

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUser;
  TextEditingController controllerPass;

  Database db;

  @override
  void initState() {
    db = Database();
    db.initiliase();
    controllerUser = TextEditingController();
    controllerPass = TextEditingController();
    super.initState();
  }

  LoginProvider loginProvider;

  LoadingProvider loadingProvider;

  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    loadingProvider = Provider.of<LoadingProvider>(context);
    // if(loginProvider.login){
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               BottomNav()));
    // }
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'مرحبا.. قم بالتسجيل اولا',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              Container(
                child: TextField(
                  controller: controllerUser,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: 'اسم المستخدم',
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextField(
                  obscureText: true,
                  controller: controllerPass,
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: 'كلمة السر',
                  ),
                ),
              ),
              Expanded(child: uploadImageButton(context)),
            ],
          ),
        ),
        loadingProvider.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(),
      ]),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                margin: const EdgeInsets.only(
                    top: 30, left: 20.0, right: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [yellow, orange],
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: FlatButton(
                  onPressed: () {
                    if (controllerUser.text.isNotEmpty &&
                        controllerPass.text.isNotEmpty) {
                      // uploadImageToFirebase(context);
                      try {
                        loadingProvider.setLoad(true);
                        loginProvider.addUser(
                            db, controllerUser.text, controllerPass.text).then((value) => addDone());


                      } catch (e) {
                        loadingProvider.setLoad(false);
                        print(e.toString());
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('اسم المستخدم وكلمة السر مطلوبين'),
                      ));
                    }
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void addDone(){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => BottomNav()));
    // Navigator.pop(context);

    loginProvider.putLogin(true);
    loadingProvider.setLoad(false);
  }


}
