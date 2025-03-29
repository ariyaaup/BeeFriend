import 'package:beefriend_app/DB_Helper/LoggedUser.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class userDatabase {
  // Buat akses DB
  final Database = Supabase.instance.client.from('UserTable');

  // CREATE
  Future signUp(UsersDB newUsers) async {
    print("halo");
    await Database.insert(newUsers.toMap());
  }

  Future SignIn(String Email, String Password) async {
    if ((Database.select('id').eq('Email', Email).single()) ==
        Database.select('id').eq('Password', Password)) {
      final response = await Database.select('id').eq('Email', Email).single();

      final userId = response['id']; // Ambil nilai ID

      print('User ID: $userId');
      Loggeduser(id: userId);
    }
  }

  // READ
  final stream = Supabase.instance.client.from('UserTable').stream(primaryKey: [
    'id'
  ]).map((data) => data.map((UserMap) => UsersDB.fromMap(UserMap)).toList());
  // UPDATE
}

// class maleDB {
//   // Buat akses DB
//   final maleDatabase = Supabase.instance.client.from('Male_User_Table');

//   // CREATE
//   Future signUp(Male_User newMaleUser) async {
//     print("halo");
//     await maleDatabase.insert(newMaleUser.toMap());
//   }

//   // READ
//   final stream = Supabase.instance.client
//       .from('Male_User_Table')
//       .stream(primaryKey: ['id']).map((data) =>
//           data.map((maleUserMap) => Male_User.fromMap(maleUserMap)).toList());

//   // UPDATE
// }

// class femaleDB {
//   // Buat akses DB
//   final femaleDatabase = Supabase.instance.client.from('Female_User_Table');

//   // CREATE
//   Future signUp(Female_User newFemaleUser) async {
//     await femaleDatabase.insert(newFemaleUser.toMap());
//   }

//   // READ
//   final stream = Supabase.instance.client
//       .from('Female_User_Table')
//       .stream(primaryKey: ['id']).map((data) => data
//           .map((femaleUserMap) => Female_User.fromMap(femaleUserMap))
//           .toList());
// }
