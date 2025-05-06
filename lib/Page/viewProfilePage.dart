import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Viewprofilepage extends StatefulWidget {
  final String name;
  final String age;
  final String img;
  final String birthdate;
  const Viewprofilepage(
      {super.key,
      required this.name,
      required this.age,
      required this.img,
      required this.birthdate});
  //tambahin semuanya pokoknya

  @override
  State<Viewprofilepage> createState() => _ViewprofilepageState();
}

Widget buildTextBackgroundRow(List<String> texts,
    {Color backgroundColor = const Color(0xFFEC7FA9),
    double borderRadius = 10.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8)}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: texts
        .map((text) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 2.0,
                vertical: 10,
              ), //spacing antar text rownya
              padding: padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
            ))
        .toList(),
  );
}

class _ViewprofilepageState extends State<Viewprofilepage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MediaQuery.of(context).size.width > 500
          ? const Color(0xFFEC7FA9)
          : const Color(0xFFEC7FA9),
      appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MediaQuery.of(context).size.width > 500
              ? const Color(0xFFEC7FA9)
              : const Color(0xFFEC7FA9),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              SizedBox(width: screenWidth * 0.05),
              Text(
                "View Profile",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Image.network(
                  widget.img,
                  fit: BoxFit.cover,
                  height: screenHeight * 1,
                ),
              ),
              buildTextBackgroundRow(
                [
                  '${widget.name}',
                  '${widget.age}',
                  '${widget.age}',
                ], //nanti biar list disini banyak
              ),
              // Text(widget.name),
              // Text(widget.age),
              // Text(widget.birthdate),
              SizedBox(
                height: screenHeight * 0.5, //lebar kebawah
              ),
            ],
          ),
        ),
      ),
    );
  }
}
