import 'package:beefriend_app/Page/Gender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDate extends StatefulWidget {
  final String Email;
  final String Password;
  final String Fullname;
  const BirthDate(
      {super.key,
      required this.Email,
      required this.Password,
      required this.Fullname});

  @override
  State<BirthDate> createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  final TextEditingController _controllerBirthDate = TextEditingController();

  int age = 0;

//fungsi date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // print(((DateTime.now().day.toInt() - pickedDate.day) *
      //         (2025 - pickedDate.year)) /
      //     365);
      if (pickedDate.day <= DateTime.now().day.toInt() &&
              pickedDate.month == DateTime.now().month.toInt() ||
          pickedDate.month < DateTime.now().month.toInt()) {
        age = 2025 - pickedDate.year;
      } else if (pickedDate.day >= DateTime.now().day.toInt() &&
              pickedDate.month == DateTime.now().month.toInt() ||
          pickedDate.month > DateTime.now().month.toInt()) {
        age = 2024 - pickedDate.year;
      }
      print(age.toString());
      String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
      setState(() {
        _controllerBirthDate.text = formattedDate;
      });
    }
  }

  void nextOnPressed() {
    var navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (builder) {
          return Gender(
            Email: widget.Email,
            Password: widget.Password,
            Fullname: widget.Fullname,
            Birthdate: _controllerBirthDate.text,
            Age: age,
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
                "Your B-Day?",
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
            // TEXT FIELD TANGGAL
            GestureDetector(
              onTap: () => _selectDate(context), // Saat tap, panggil DatePicker
              child: AbsorbPointer(
                child: TextField(
                  controller: _controllerBirthDate,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: const Color(0xFFFFFFFF),
                    filled: true,
                    hintText: 'MM/DD/YYYY',
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your profile shows your age, not your birth date.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_controllerBirthDate.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Please fill your birth date!",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      backgroundColor: Color(0xFF98476A),
                    ),
                  );
                } else {
                  // Kirim ke database
                  // print("Tanggal Lahir: ${_controllerBirthDate.text}");
                  // saveToDatabase(_controllerBirthDate.text); --> tinggal dipanggil
                  print(_controllerBirthDate.toString());
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
