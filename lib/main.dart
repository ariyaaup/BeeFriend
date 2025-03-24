import 'package:beefriend_app/Page/CampusInformation.dart';
import 'package:beefriend_app/Page/Distance.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:beefriend_app/Page/LoginPage.dart';
import 'package:beefriend_app/Page/FirstName.dart';
import 'package:beefriend_app/Page/BirthDate.dart';
import 'package:beefriend_app/Page/Gender.dart';
import 'package:beefriend_app/Page/LookingFor.dart';
import 'package:beefriend_app/Page/RegisterPage.dart';
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
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/homePage': (BuildContext context) => HomePage(),
        '/CampusInformation': (BuildContext context) => CampusInformation(),
        '/RegisterPage': (BuildContext context) => RegisterPage(),
        '/loginPage': (BuildContext context) => LoginPage(),
        '/FirstName': (BuildContext context) => FirstName(),
        '/BirthDate': (BuildContext context) => BirthDate(),
        '/LookingFor': (BuildContext context) => LookingFor(),
        '/Distance': (BuildContext context) => Distance(),
        '/Gender': (BuildContext context) => Gender(),
        // '/profilePage': (BuildContext context) => ProfilePage(),
      },
    );
  }
}
