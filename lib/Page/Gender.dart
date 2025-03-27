import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/Page/LookingFor.dart';
import 'package:beefriend_app/Page/RegisterPage.dart';
import 'package:flutter/material.dart';

class Gender extends StatefulWidget {
  final String Email;
  final String Password;
  final String Fullname;
  final String Birthdate;
  const Gender(
      {super.key,
      required this.Email,
      required this.Password,
      required this.Fullname,
      required this.Birthdate});

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String selectedGender = ""; // yang dipilih gendernya
  int GenderID = 0;

  void nextOnPressed(int gender) {
    if (selectedGender != "") {
      var navigator = Navigator.of(context);
      navigator.push(
        MaterialPageRoute(
          builder: (builder) {
            return LookingFor(
              Email: widget.Email,
              Password: widget.Password,
              Fullname: widget.Fullname,
              Birthdate: widget.Birthdate,
              gender: gender,
            );
          },
        ),
      );
    }
    if (selectedGender == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Must Choose a Gender",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    }
    if (GenderID == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Must Choose a Gender",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    }
  }

  final List<String> genderOptions = ["Female", "Male"];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MediaQuery.of(context).size.width > 500
            ? Color(0xFFEC7FA9)
            : Color(0xFFEC7FA9),
      ),
      body: Container(
        color: MediaQuery.of(context).size.width > 500
            ? Color(0xFFEC7FA9)
            : Color(0xFFEC7FA9),
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
              height: screenHeight * 0.11,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What's your Gender?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            // Gender Options
            Column(
              children: genderOptions.map((gender) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedGender == gender) {
                          selectedGender = ""; // Unselect jika tap lagi
                        } else {
                          selectedGender = gender; // Select new
                          if (selectedGender == "Female") {
                            GenderID = 1;
                          } else {
                            GenderID = 2;
                          }
                          print(GenderID.toString());
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height *
                            0.02, // vertical padding
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ), //horizontal padding
                      decoration: BoxDecoration(
                        color: selectedGender == gender
                            ? Colors.white
                            : Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          gender,
                          style: TextStyle(
                            color: selectedGender == gender
                                ? MediaQuery.of(context).size.width > 500
                                    ? Color(0xFFEC7FA9)
                                    : Color(0xFFEC7FA9)
                                : Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                nextOnPressed(GenderID);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFEC7FA9),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Colors.white,
                    )),
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
