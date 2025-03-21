import 'package:beefriend_app/Page/LoginPage.dart';
import 'package:beefriend_app/Page/RegistPage.dart';
import 'package:beefriend_app/Page/RegistPage2.dart';
import 'package:beefriend_app/Page/RegistPage3.dart';
import 'package:beefriend_app/Page/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // scaffoldBackgroundColor: Colors.tran,
          ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        // '/homePage': (BuildContext context) => HomePage(),
        '/loginPage': (BuildContext context) => LoginPage(),
        '/RegistPage': (BuildContext context) => RegistPage(),
        '/RegistPage2': (BuildContext context) => RegistPage2(),
        '/RegistPage3': (BuildContext context) => RegisterPage3(),
        // '/profilePage': (BuildContext context) => ProfilePage(),
      },
    );
  }
}
