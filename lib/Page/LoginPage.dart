import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String errorMessage = ' ';
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFFEC7FA9),
      ),
      body: Container(
        color: Color(0xFFEC7FA9),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello, Bee👋",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _controllerEmail,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF333333),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                fillColor: const Color(0xFFFFFFFF),
                filled: true,
                hintText: 'Username',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controllerPassword,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF333333),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                fillColor: const Color(0xFFFFFFFF),
                filled: true,
                hintText: 'Password',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                // signInWithEmailAndPassword();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFEC7FA9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white,
                    )),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Dont have an account? Sign UP",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
