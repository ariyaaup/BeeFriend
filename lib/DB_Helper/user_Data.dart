// import 'dart:ffi';

// import 'package:beefriend_app/Page/Gender.dart';
// import 'package:flutter/foundation.dart';

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
  int HobiID;
  int ZodiakID;
  int EthnicID;
  int AgamaID;
  String ProfilePicture;

  final String? AgamaName;
  final String? ZodiakName;
  final String? EthnicName;
  final String? AngkatanName;
  final String? HobiName;

  // String? Agama;
  // String? Hobi;
  // String? Zodiak;
  // String? Ethnic;
  // String? Angkatan;

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
    required this.AgamaID,
    required this.EthnicID,
    required this.HobiID,
    required this.ZodiakID,
    required this.ProfilePicture,
    this.AgamaName,
    this.AngkatanName,
    this.EthnicName,
    this.HobiName,
    this.ZodiakName,
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
      Distance: (map['Distance'] as num).toDouble(),
      LookingForID: map['LookingForID'] as int,
      GenderID: map['GenderID'] as int,
      AngkatanID: map['AngkatanID'] as int,
      AgamaID: map['AgamaID'] as int,
      ZodiakID: map['ZodiakID'] as int,
      HobiID: map['HobiID'] as int,
      EthnicID: map['EthnicID'] as int,
      ProfilePicture: map['ProfilePicture'] as String,
      AgamaName: map['Agama']?['Agama'] as String?,
      ZodiakName: map['Zodiak']?['Zodiak'] as String?,
      EthnicName: map['Ethnic']?['Ethnic'] as String?,
      AngkatanName: map['Angkatan']?['Angkatan'] as String?,
      HobiName: map['Hobi']?['Hobi'] as String?,
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
      'AgamaID': AgamaID,
      'ZodiakID': ZodiakID,
      'HobiID': HobiID,
      'EthnicID': EthnicID,
      'ProfilePicture': ProfilePicture,
      // 'Agama': Agama,
      // 'Hobi': Hobi,
      // 'Angkatan': Angkatan,
      // 'Zodiak': Zodiak,
      // 'Ethnic': Ethnic,
    };
  }
}

class userChat {
  int? id;
  String Email1;
  String Email2;

  userChat({
    this.id,
    required this.Email1,
    required this.Email2,
  });

  factory userChat.fromMap(Map<String, dynamic> map) {
    return userChat(
      // id: map['id'] as int,
      Email1: map['Email_1'] as String,
      Email2: map['Email_2'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'Email_1': Email1,
      'Email_2': Email2,
    };
  }
}
