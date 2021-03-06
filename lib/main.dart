

import 'package:flutter/material.dart';
import 'package:zm_supplier/utils/constants.dart';
import 'login/login_page.dart';
import 'home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zm_supplier/model//authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
  };

  SharedPref sharedPref = SharedPref();

  // loadSharedPrefs() async {
  //   try {
  //     LoginResponse user = LoginResponse.fromJson(
  //         await sharedPref.readData(Constants.loginInfo));
  //     //setState(() {
  //       print(user.user.userId);
  //       print(user.user.email);
  //       if ()user.user.userId != null) {
  //
  //       }
  //    // });
  //   } catch (Excepetion) {
  //     // do something
  //   }
  // }



  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}