// import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/AuthService.dart';
// import 'package:beefriend_app/DB_Helper/LoggedUser.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:beefriend_app/Page/RegisterPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void signInWithEmailAndPassword(String email, String password) async {
    try {
      final response =
          await AuthService().signInWithEmailPassword(email, password);

      if (response.session == null) {
        throw Exception(
            "Login gagal. Periksa kembali email dan password Anda.");
      }

      print("Login berhasil: ${response.session?.user.email}");
      var navigator = Navigator.of(context);
      navigator.push(
        MaterialPageRoute(
          builder: (builder) {
            return const HomePage();
          },
        ),
      );
    } catch (e) {
      print("Error saat login: $e");
    }
  }

  // @override
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String errorMessage = ' ';
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MediaQuery.of(context).size.width > 500
              ? const Color(0xFFEC7FA9)
              : const Color(0xFFEC7FA9),
        ),
        body: Container(
          color: MediaQuery.of(context).size.width > 500
              ? const Color(0xFFEC7FA9)
              : const Color(0xFFEC7FA9),
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Hello, Bee👋",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your binusian email",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextField(
                controller: _controllerEmail,
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: false,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: const Color(0xFFFFFFFF),
                  filled: true,
                  hintText: 'Fill your Binusian Email',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your password",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              TextField(
                controller: _controllerPassword,
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  fillColor: const Color(0xFFFFFFFF),
                  filled: true,
                  hintText: 'Fill your password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword(
                      _controllerEmail.text, _controllerPassword.text);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFEC7FA9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                        color: Colors.white,
                      )),
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign UP',
                      style: const TextStyle(
                        color: Colors.white,
                        decoration:
                            TextDecoration.underline, // underline effect
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          var navigator = Navigator.of(context);
                          navigator.push(
                            MaterialPageRoute(
                              builder: (builder) {
                                return const RegisterPage();
                              },
                            ),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
