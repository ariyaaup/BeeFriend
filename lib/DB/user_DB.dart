// import 'package:beefriend_app/DB_Helper/LoggedUser.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class userDatabase {
  // Buat akses DB
  final Database = Supabase.instance.client.from('UserTable');
  final Databases = Supabase.instance.client.from('FemaletoMale');
  final Databasess = Supabase.instance.client.from('MaletoFemale');

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
    }
  }

  Future ChatLogic(userChat newChat) async {
    await Databasess.insert(newChat.toMap());
  }

  // READ
  final stream = Supabase.instance.client.from('UserTable').stream(primaryKey: [
    'id'
  ]).map((data) => data.map((UserMap) => UsersDB.fromMap(UserMap)).toList());
  // UPDATE

  Future UpdateProfilePicture(String Email, String FileName) async {
    await Database.update({'ProfilePicture': FileName}).eq('Email', Email);
  }
}

class showData {
  final SupabaseClient _supabase = Supabase.instance.client;
  Future<String?> getUserIdByEmail(String email) async {
    final response =
        await _supabase.rpc('get_user_id_by_email', params: {'email': email});
    print("User ID: $response");

    return response;
  }

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final response = await Supabase.instance.client
        .from('UserTable')
        .select(
            '*, Region(*), Looking_For(*), Gender(*), Angkatan(*), Agama(*), Hobi(*), Zodiak(*), Ethnic(*)')
        .eq('Email', email)
        .single();

    return response;
  }
  // var response = await Supabase.instance.client
  //         .from('UserTable')
  //         .select()
  //         .eq("GenderID", "1")
  //         .limit(20);
  //     var responses = await Supabase.instance.client
  //         .from('UserTable')
  //         .select()
  //         .eq('GenderID', "2")
  //         .limit(20);

  Future<Map<String, dynamic>?> getUserDataByFilteredFemale(
      {int? agama, int? hobi, int? angkatan, int? ethnic, int? zodiak}) async {
    print('TestBrooo');

    var query =
        Supabase.instance.client.from('UserTable').select().eq('GenderID', "1");
    if (agama != null) query = query.eq('AgamaID', agama);
    if (hobi != null) query = query.eq('HobiID', hobi);
    if (angkatan != null) query = query.eq('AngkatanID', angkatan);
    if (ethnic != null) query = query.eq('EthnicID', ethnic);
    if (zodiak != null) query = query.eq('ZodiakID', zodiak);

    final response = await query.maybeSingle();
    return response;
  }

  Future<Map<String, dynamic>?> getUserDataByFilteredMale(
      {int? agama,
      int? hobi,
      int? angkatan,
      int? ethnic,
      int? zodiak,
      String? email}) async {
    // print('TestBrooo');

    var querys =
        Supabase.instance.client.from('UserTable').select().eq('GenderID', "2");

    if (agama != null) querys = querys.eq('AgamaID', agama);
    if (hobi != null) querys = querys.eq('HobiID', hobi);
    if (angkatan != null) querys = querys.eq('AngkatanID', angkatan);
    if (ethnic != null) querys = querys.eq('EthnicID', ethnic);
    if (zodiak != null) querys = querys.eq('ZodiakID', zodiak);
    if (email != null) querys = querys.neq('Email', email);

    final response = await querys.maybeSingle();
    return response;
  }

  Future<List<Map<String, dynamic>>> getUserDataByFiltered({
    required int genderId, // 1 = female, 2 = male
    int? agama,
    int? hobi,
    int? angkatan,
    int? ethnic,
    int? zodiak,
    String? email,
  }) async {
    print('Fetching filtered user data...');

    print(email);

    var query = Supabase.instance.client
        .from('UserTable')
        .select(
            '*, Region(*), Looking_For(*), Gender(*), Angkatan(*), Agama(*), Hobi(*), Zodiak(*), Ethnic(*)')
        .eq('GenderID', genderId);

    if (agama != null) query = query.eq('AgamaID', agama);
    if (hobi != null) query = query.eq('HobiID', hobi);
    if (angkatan != null) query = query.eq('AngkatanID', angkatan);
    if (ethnic != null) query = query.eq('EthnicID', ethnic);
    if (zodiak != null) query = query.eq('ZodiakID', zodiak);
    if (email != null) query = query.neq('Email', email);

    final response = await query;
    // print('HALOOOO ${response}');
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  // Future<List<Map<String, dynamic>>> AlreadyLiked(String Email) async {
  //   final _supabase = Supabase.instance.client;

  //   final response = await _supabase
  //       .from("MaletoFemale")
  //       .select('Email_2')
  //       .eq('Email_1', Email);

  //   return (response as List).cast<Map<String, dynamic>>();
  // }

  Future<String> AlreadyLiked(String Email) async {
    final _supabase = Supabase.instance.client;

    final response = await _supabase
        .from("MaletoFemale")
        .select('Email_2')
        .eq('Email_1', Email);

    List<String> emails =
        response.map<String>((item) => item['Email_2'] as String).toList();

    return emails.join(', '); // Gabung jadi satu string, dipisah koma
  }
}
