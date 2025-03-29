import 'package:beefriend_app/Page/Distance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LookingFor extends StatefulWidget {
  final String Email;
  final String Password;
  final String Fullname;
  final String Birthdate;
  final int gender;
  final int age;
  const LookingFor({
    super.key,
    required this.Email,
    required this.Password,
    required this.Fullname,
    required this.Birthdate,
    required this.gender,
    required this.age,
  });

  @override
  State<LookingFor> createState() => _LookingForState();
}

final List<Map<String, String>> options = [
  {"emoji": "💘", "text": "Long-term\npartner"},
  {"emoji": "💖", "text": "Long-term,\nopen to short"},
  {"emoji": "🍻", "text": "Short-term,\nopen to long"},
  {"emoji": "🎉", "text": "Short-term\nfun"},
  {"emoji": "👋", "text": "New\nFriends"},
  {"emoji": "🤔", "text": "Still\nfiguring it out"},
];
String selectedOption = "";
int LookingForID = 0;

class _LookingForState extends State<LookingFor> {
  void nextOnPressed(int lookingForID) {
    if (selectedOption != "") {
      var navigator = Navigator.of(context);
      navigator.push(
        MaterialPageRoute(
          builder: (builder) {
            return Distance(
              Email: widget.Email,
              Password: widget.Password,
              Fullname: widget.Fullname,
              Birthdate: widget.Birthdate,
              gender: widget.gender,
              LookingFor: lookingForID,
              age: widget.age,
            );
          },
        ),
      );
    }
    if (selectedOption == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Must Choose an Option",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    }
    if (LookingForID == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Must Choose an Option",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xFF98476A),
        ),
      );
    }
  }

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
        // elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: MediaQuery.of(context).size.width > 500
              ? Color(0xFFEC7FA9)
              : Color(0xFFEC7FA9),
          // height: screenHeight * 0.01,
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
                height: screenHeight * 0.04,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What are you looking for?",
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
                  "All good if it changes. There’s something for everyone",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              // Gridview option
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = selectedOption == option['text'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedOption = ""; // Unselect
                        } else {
                          selectedOption = option['text']!;
                          if (selectedOption == "Long-term\npartner") {
                            LookingForID = 1;
                          }
                          if (selectedOption == "Long-term,\nopen to short") {
                            LookingForID = 2;
                          }
                          if (selectedOption == "Short-term,\nopen to long") {
                            LookingForID = 3;
                          }
                          if (selectedOption == "Short-term\nfun") {
                            LookingForID = 4;
                          }
                          if (selectedOption == "New\nFriends") {
                            LookingForID = 5;
                          }
                          if (selectedOption == "Still\nfiguring it out") {
                            LookingForID = 6;
                          }
                          print(LookingForID.toString());
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Color(0xFFEC7FA9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            option['emoji']!,
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(height: 10),
                          Text(
                            option['text']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  isSelected ? Color(0xFFEC7FA9) : Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedOption.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please select one option!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        backgroundColor: Color(0xFF98476A),
                      ),
                    );
                  } else {
                    nextOnPressed(LookingForID);
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
      ),
    );
  }
}
