import 'package:beefriend_app/Page/LoginPage.dart';
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
      theme: ThemeData(),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        // '/homePage': (BuildContext context) => HomePage(),
        '/loginPage': (BuildContext context) => LoginPage(),
        // '/registPage': (BuildContext context) => RegisterPage(),
        // '/profilePage': (BuildContext context) => ProfilePage(),
      },
    );
  }
}
