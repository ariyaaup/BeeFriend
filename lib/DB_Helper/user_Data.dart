import 'dart:ffi';

import 'package:beefriend_app/Page/Gender.dart';
import 'package:flutter/foundation.dart';

class UsersDB {
  String id;
  // String Username;
  String FullName;
  String Password;
  String Gmail;
  int Age;
  String BirthDate;
  int RegionID;
  double Distance;
  int LookingForID;
  int GenderID;
  int AngkatanID;

  UsersDB({
    required this.id,
    // required this.Username,
    required this.FullName,
    required this.Password,
    required this.Gmail,
    required this.Age,
    required this.BirthDate,
    required this.RegionID,
    required this.Distance,
    required this.LookingForID,
    required this.GenderID,
    required this.AngkatanID,
  });

  factory UsersDB.fromMap(Map<String, dynamic> map) {
    return UsersDB(
      id: map['id'] as String,
      // Username: map['Username'] as String,
      FullName: map['Fullname'] as String,
      Password: map['Password'] as String,
      Gmail: map['Email'] as String,
      Age: map['Age'] as int,
      BirthDate: map['BirthDate'] as String,
      RegionID: map['RegionID'] as int,
      Distance: map['Distance'] as double,
      LookingForID: map['LookingForID'] as int,
      GenderID: map['GenderID'] as int,
      AngkatanID: map['AngkatanID'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'male_Username': Username,
      'id': id,
      'Fullname': FullName,
      'Password': Password,
      'Email': Gmail,
      'Age': Age,
      'BirthDate': BirthDate,
      'RegionID': RegionID,
      'Distance': Distance,
      'LookingForID': LookingForID,
      'AngkatanID': AngkatanID,
      'GenderID': GenderID,
    };
  }
}

// class Male_User {
//   int? id;
//   String Username;
//   String FullName;
//   String Password;
//   String Gmail;
//   int Age;
//   String BirthDate;
//   int RegionID;
//   int Distance;
//   int LookingForID;

//   Male_User({
//     this.id,
//     required this.Username,
//     required this.FullName,
//     required this.Password,
//     required this.Gmail,
//     required this.Age,
//     required this.BirthDate,
//     required this.RegionID,
//     required this.Distance,
//     required this.LookingForID,
//   });

//   factory Male_User.fromMap(Map<String, dynamic> map) {
//     return Male_User(
//         id: map['id'] as int,
//         Username: map['male_Username'] as String,
//         FullName: map['male_Fullname'] as String,
//         Password: map['male_Password'] as String,
//         Gmail: map['male_Gmail'] as String,
//         Age: map['male_Age'] as int,
//         BirthDate: map['male_BirthDate'] as String,
//         RegionID: map['RegionID'] as int,
//         Distance: map['male_Distance'] as int,
//         LookingForID: map['LookingForID'] as int);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'male_Username': Username,
//       'male_Fullname': FullName,
//       'male_Password': Password,
//       'male_Gmail': Gmail,
//       'male_Age': Age,
//       'male_BirthDate': BirthDate,
//       'RegionID': RegionID,
//       'male_Distance': Distance,
//       'LookingForID': LookingForID,
//     };
//   }
// }

// class Female_User {
//   int? id;
//   String Username;
//   String FullName;
//   String Password;
//   String Gmail;
//   int Age;
//   String BirthDate;
//   int RegionID;
//   int Distance;
//   int LookingForID;

//   Female_User({
//     this.id,
//     required this.Username,
//     required this.FullName,
//     required this.Password,
//     required this.Gmail,
//     required this.Age,
//     required this.BirthDate,
//     required this.RegionID,
//     required this.Distance,
//     required this.LookingForID,
//   });

//   factory Female_User.fromMap(Map<String, dynamic> map) {
//     return Female_User(
//         id: map['id'] as int,
//         Username: map['female_Username'].toString(),
//         FullName: map['female_Fullname'].toString(),
//         Password: map['female_Password'].toString(),
//         Gmail: map['female_Gmail'].toString(),
//         Age: map['female_Age'] as int,
//         BirthDate: map['female_BirthDate'] as String,
//         RegionID: map['RegionID'] as int,
//         Distance: map['female_Distance'] as int,
//         LookingForID: ['LookingForID'] as int);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'female_Username': Username,
//       'female_Fullname': FullName,
//       'female_Password': Password,
//       'female_Gmail': Gmail,
//       'female_Age': Age,
//       'female_BirthDate': BirthDate,
//       'RegionID': RegionID,
//       'female_Distance': Distance,
//       'LookingForID': LookingForID,
//     };
//   }
// }
