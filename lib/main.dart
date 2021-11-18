import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_app_firebase/prev/data_provider.dart';
import 'package:test_app_firebase/provider/loading_provider.dart';
import 'package:test_app_firebase/provider/login_provider.dart';
import 'package:test_app_firebase/screens/login.dart';
import 'package:test_app_firebase/screens/main.dart';

import 'db_firebase/database.dart';

// void main() {
//   runApp(MultiProvider(
//       // providers: [
//       //
//       // ],
//       child: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Test',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: Home(),
//     );
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Database db;

  LoginProvider loginProvider = LoginProvider();
  LoadingProvider loadingProvider = LoadingProvider();

  DataProvider dataProvider;

  @override
  void initState() {
    // TODO: implement initState
    db = Database();
    db.initiliase();
    dataProvider = DataProvider(db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: Init.instance.initialize(),
    //     builder: (context, AsyncSnapshot snapshot) {
    //       // Show splash screen while waiting for app resources to load:
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return  MaterialApp(home: Splash());
    //       } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) {
                  return loginProvider;
                }),
                ChangeNotifierProvider(create: (_) {
                  return dataProvider;
                }),
                ChangeNotifierProvider(create: (_) {
                  return loadingProvider;
                }),
              ],
                child:
                Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                  print('login status ------------------------- ##################'+loginProvider.login.toString());
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Firebase',
                    theme: ThemeData(
                      primaryColor: Colors.black,
                      primaryColorLight: Colors.black,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    home: loginProvider.login ? BottomNav(): Login(),
                  );
                }));


          }

  }


// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     bool lightMode =
//         MediaQuery.of(context).platformBrightness == Brightness.light;
//     return Scaffold(
//       backgroundColor:
//           lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
//       body: Center(
//           child: lightMode
//               ? Image.asset('assets/splash.png')
//               : Image.asset('assets/splash_dark.png')),
//     );
//   }
// }
//
// class Init {
//   Init._();
//
//   static final instance = Init._();
//
//   Future initialize() async {
//     // This is where you can initialize the resources needed by your app while
//     // the splash screen is displayed.  Remove the following example because
//     // delaying the user experience is a bad design practice!
//     await Future.delayed(const Duration(seconds: 3));
//   }
// }
