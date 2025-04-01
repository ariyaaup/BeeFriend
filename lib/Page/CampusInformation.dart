import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/AuthService.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:beefriend_app/Page/HomePage.dart';
import 'package:beefriend_app/Page/InputFoto.dart';
import 'package:beefriend_app/Page/LoginPage.dart';
import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart'; //gakepake cok

class CampusInformation extends StatefulWidget {
  final String Email;
  final String Password;
  final String Fullname;
  final String Birthdate;
  final int gender;
  final int LookingFor;
  final double Distance;
  final int age;
  const CampusInformation({
    super.key,
    required this.Email,
    required this.Password,
    required this.Fullname,
    required this.Birthdate,
    required this.gender,
    required this.Distance,
    required this.LookingFor,
    required this.age,
  });

  @override
  State<CampusInformation> createState() => _CampusInformationState();
}

class _CampusInformationState extends State<CampusInformation> {
  final database = userDatabase();
  @override
  String selectedLocation = '';
  String selectedBinusian = '';
  int LocationID = 0;

  void nextOnPressed(int angkatanID) async {
    // print(" UID : ${AuthService().getUserIdByEmail(widget.Email).toString()}");
    final userId = await AuthService().getUserIdByEmail(widget.Email);
    print("User ID: ${userId.toString()}");
    final newUser = UsersDB(
      id: userId.toString(),
      FullName: widget.Fullname.toString(),
      Password: widget.Password.toString(),
      Gmail: widget.Email.toString(),
      Age: widget.age,
      BirthDate: widget.Birthdate.toString(),
      RegionID: LocationID,
      Distance: widget.Distance,
      LookingForID: widget.LookingFor,
      GenderID: widget.gender,
      AngkatanID: angkatanID,
    );

    var userDB = userDatabase();
    userDB.signUp(newUser);

    var navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (builder) {
          return LoginPage();
        },
      ),
    );
  }

  List<String> campusLocation = [
    'Kemanggisan',
    'Alam Sutera',
    'Senayan',
    'Bandung',
    'Bekasi',
    'Malang',
    'Semarang'
  ];
  List<String> binusian = [
    'B28',
    'B27',
    'B26',
    'B25',
    'B24',
    'B23',
    'B22',
    'B21',
    'B20',
    'Older'
  ];

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    int AngkatanIDS = 0;
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
                "Your campus information",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Campus Location",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            // < ====== DROPDOWN CAMPUS LOCATION ====== >
            Container(
              width: screenWidth * 1,
              height: screenHeight * 0.07,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                value: selectedLocation.isEmpty ? null : selectedLocation,
                hint: Text("Select location"),
                items: campusLocation
                    .map(
                      (loc) => DropdownMenuItem(
                        value: loc,
                        child: Text(loc),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (selectedLocation == value) {
                      selectedLocation = '';
                    } else {
                      selectedLocation = value.toString();
                      if (selectedLocation == "Kemanggisan") {
                        LocationID = 1;
                      } else if (selectedLocation == "Alam Sutera") {
                        LocationID = 2;
                      } else if (selectedLocation == "Senayan") {
                        LocationID = 3;
                      } else if (selectedLocation == "Bandung") {
                        LocationID = 4;
                      } else if (selectedLocation == "Bekasi") {
                        LocationID = 5;
                      } else if (selectedLocation == "Malang") {
                        LocationID = 6;
                      } else if (selectedLocation == "Semarang") {
                        LocationID = 7;
                      }
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Binusian",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            // < ====== DROPDOWN binusian ====== >
            Container(
              width: screenWidth * 1,
              height: screenHeight * 0.07,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                value: selectedBinusian.isEmpty ? null : selectedBinusian,
                hint: Text("Binusian"),
                items: binusian
                    .map(
                      (bn) => DropdownMenuItem(
                        value: bn,
                        child: Text(bn),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (selectedBinusian == value) {
                      selectedBinusian = '';
                    } else {
                      selectedBinusian = value.toString();
                    }
                  });
                },
                menuMaxHeight: 200,
              ),
            ),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedLocation.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please set your campus location!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      backgroundColor: Color(0xFF98476A),
                    ),
                  );
                } else if (selectedBinusian.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please set your binusian!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      backgroundColor: Color(0xFF98476A),
                    ),
                  );
                } else {
                  if (selectedBinusian == "B28") {
                    AngkatanIDS = 1;
                  } else if (selectedBinusian == "B27") {
                    AngkatanIDS = 2;
                  } else if (selectedBinusian == "B26") {
                    AngkatanIDS = 3;
                  } else if (selectedBinusian == "B25") {
                    AngkatanIDS = 4;
                  } else if (selectedBinusian == "B24") {
                    AngkatanIDS = 5;
                  } else if (selectedBinusian == "B23") {
                    AngkatanIDS = 6;
                  } else if (selectedBinusian == "B22") {
                    AngkatanIDS = 7;
                  } else if (selectedBinusian == "B21") {
                    AngkatanIDS = 8;
                  } else if (selectedBinusian == "B20") {
                    AngkatanIDS = 9;
                  } else if (selectedBinusian == "Older") {
                    AngkatanIDS = 10;
                  }

                  nextOnPressed(AngkatanIDS);
                }
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
