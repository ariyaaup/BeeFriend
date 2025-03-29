import 'package:beefriend_app/Page/CampusInformation.dart';
import 'package:beefriend_app/Page/Distance.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:beefriend_app/Page/LoginPage.dart';
import 'package:beefriend_app/Page/FirstName.dart';
import 'package:beefriend_app/Page/BirthDate.dart';
import 'package:beefriend_app/Page/Gender.dart';
import 'package:beefriend_app/Page/LookingFor.dart';
import 'package:beefriend_app/Page/InputFoto.dart';
import 'package:beefriend_app/Page/ProfilePage.dart';
import 'package:beefriend_app/Page/RegisterPage.dart';
import 'package:beefriend_app/Page/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://vijmhqxnqqtxsdrkxlrw.supabase.co",
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZpam1ocXhucXF0eHNkcmt4bHJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMwNTY2OTksImV4cCI6MjA1ODYzMjY5OX0.McTdHXV3mTckJnYXq_gm5xY727S90YXTHllEyAPnj1E',
  );
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
        '/homePage': (BuildContext context) => HomePage(),
        // '/CampusInformation': (BuildContext context) => CampusInformation(),
        '/RegisterPage': (BuildContext context) => RegisterPage(),
        '/loginPage': (BuildContext context) => LoginPage(),
        // '/FirstName': (BuildContext context) => FirstName(),
        // '/BirthDate': (BuildContext context) => BirthDate(),
        // '/LookingFor': (BuildContext context) => LookingFor(),
        // '/Distance': (BuildContext context) => Distance(),
        // '/Gender': (BuildContext context) => Gender(),
        // '/profilePage': (BuildContext context) => ProfilePage(),
      },
    );
  }
}
