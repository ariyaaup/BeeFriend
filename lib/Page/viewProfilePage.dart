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

  @override
  State<Viewprofilepage> createState() => _ViewprofilepageState();
}

class _ViewprofilepageState extends State<Viewprofilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.img),
            Text(widget.name),
            Text(widget.age),
            Text(widget.birthdate),
          ],
        ),
      ),
    );
  }
}
