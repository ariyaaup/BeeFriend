import 'package:beefriend_app/Page/CampusInformation.dart';
import 'package:flutter/material.dart';

class Distance extends StatefulWidget {
  final String Email;
  final String Password;
  final String Fullname;
  final String Birthdate;
  final int gender;
  final int LookingFor;
  final int age;
  const Distance({
    super.key,
    required this.Email,
    required this.Password,
    required this.Fullname,
    required this.Birthdate,
    required this.gender,
    required this.LookingFor,
    required this.age,
  });

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  double _currentSliderValue = 0; //slider nilainya

  void nextOnPressed(double sliderValue) {
    var navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (builder) {
          return CampusInformation(
            Email: widget.Email,
            Password: widget.Password,
            Fullname: widget.Fullname,
            Birthdate: widget.Birthdate,
            gender: widget.gender,
            LookingFor: widget.LookingFor,
            Distance: sliderValue,
            age: widget.age,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                "Your distance preference?",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Use the slider to set the maximum distance you want your potential matches to be located",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Distance Preference",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 11,
                ),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                inactiveTrackColor: Colors.white.withOpacity(0.3),
                thumbColor: Colors.white,
                overlayColor: Colors.white.withOpacity(0.2),
                valueIndicatorColor:
                    Color(0xFF98476A), //warna penanda disctance nya
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                trackHeight: 2,
              ),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 10,
                divisions: 10,
                label: "${_currentSliderValue.round()} Km",
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    print(_currentSliderValue.toString());
                  });
                },
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_currentSliderValue == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please set your distance preference!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      backgroundColor: Color(0xFF98476A),
                    ),
                  );
                } else {
                  // Arahkan ke page selanjutnya
                  nextOnPressed(_currentSliderValue);
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
