
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app_firebase/provider/login_provider.dart';
import 'package:test_app_firebase/screens/first_page.dart';

import 'add_post.dart';
import 'login.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}



class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddPost(),
    Container(
      color: Colors.green,
      child: Center(child: Text("Page 2")),
      constraints: BoxConstraints.expand(),
    ),
    Container(
      color: Colors.green,
      child: Center(child: Text("Page 3")),
      constraints: BoxConstraints.expand(),
    )
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider =  Provider.of<LoginProvider>(context);


    // if(loginProvider.login){
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               Login()));
    //   Navigator.pop(context);
    // }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),;
      // ),
      body: _widgetOptions[_selectedIndex],
      // body: Center(child:Text('Home')),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('الرئيسية'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('المصادر'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('رياضة'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('حواء'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
