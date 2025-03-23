import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart'; //gakepake cok

class CampusInformation extends StatefulWidget {
  const CampusInformation({super.key});

  @override
  State<CampusInformation> createState() => _CampusInformationState();
}

class _CampusInformationState extends State<CampusInformation> {
  @override
  String selectedLocation = '';
  String selectedBinusian = '';

  List<String> campusLocation = [
    'Binus \@Alam Sutera',
    'Kemanggisan',
    'Bandung',
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
                  Navigator.pushNamed(context, '/RegisterPage');
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
