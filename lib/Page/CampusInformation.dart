import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
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
  const CampusInformation({
    super.key,
    required this.Email,
    required this.Password,
    required this.Fullname,
    required this.Birthdate,
    required this.gender,
    required this.Distance,
    required this.LookingFor,
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

  void nextOnPressed() {
    print("halo");
    print(widget.Birthdate.toString());
    print(widget.Distance.toString());
    print(widget.Fullname.toString());
    print(widget.LookingFor.toString());
    print(widget.Fullname.toString());
    print(widget.gender.toString());

    final newUser = UsersDB(
      FullName: widget.Fullname.toString(),
      Password: widget.Password.toString(),
      Gmail: widget.Email.toString(),
      Age: 18,
      BirthDate: widget.Birthdate.toString(),
      RegionID: LocationID,
      Distance: widget.Distance,
      LookingForID: widget.LookingFor,
      GenderID: widget.gender,
    );

    var userDB = userDatabase();
    userDB.signUp(newUser);
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
                      }
                      if (selectedLocation == "Alam Sutera") {
                        LocationID = 1;
                      }
                      if (selectedLocation == "Senayan") {
                        LocationID = 1;
                      }
                      if (selectedLocation == "Bandung") {
                        LocationID = 1;
                      }
                      if (selectedLocation == "Bekasi") {
                        LocationID = 1;
                      }
                      if (selectedLocation == "Malang") {
                        LocationID = 1;
                      }
                      if (selectedLocation == "Semarang") {
                        LocationID = 1;
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
                  nextOnPressed();
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
