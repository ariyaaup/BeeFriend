import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(100, 236, 127, 169),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Aplikasi
            Padding(
              padding:
                  const EdgeInsets.only(top: 160.0), // Jarak dari atas layar
              child: Image.asset(
                'lib/assets/BeeFriend_fix.png',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 100), // Jarak antara logo dan button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            // Tombol Get Started
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/loginPage');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    color: Color.fromRGBO(236, 127, 146, 100),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
