// import 'package:beefriend_app/DB_Helper/LoggedUser.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class userDatabase {
  // Buat akses DB
  final Database = Supabase.instance.client.from('UserTable');
  final FemaleToMale = Supabase.instance.client.from('FemaletoMale');
  final MaleToFemale = Supabase.instance.client.from('MaletoFemale');
  final ChatTable = Supabase.instance.client.from('ChatTable');
  final Topliked = Supabase.instance.client.from('TopLiked');
  final FemaleToMaleChat = Supabase.instance.client.from('FemaletoMaleChat');
  final MaleToFemaleChat = Supabase.instance.client.from('MaletoFemaleChat');
  final ReportTable = Supabase.instance.client.from('ReportTable');

  // CREATE
  Future signUp(UsersDB newUsers) async {
    print("halo");
    await Database.insert(newUsers.toMap());
  }

  Future SignIn(String Email, String Password) async {
    if ((Database.select('id').eq('Email', Email).single()) ==
        Database.select('id').eq('Password', Password)) {
      final response = await Database.select('id').eq('Email', Email).single();

      final userId = response['id'];

      print('User ID: $userId');
    }
  }

  Future LikeLogic(savedUser newChat, int gender) async {
    if (gender == 1) {
      await MaleToFemale.insert(newChat.toMap());
    } else if (gender == 2) {
      await FemaleToMale.insert(newChat.toMap());
    }
  }

  Future ChatInsert(savedUser newChat, int gender) async {
    if (gender == 1) {
      await MaleToFemaleChat.insert(newChat.toMap());
    } else if (gender == 2) {
      await FemaleToMaleChat.insert(newChat.toMap());
    }
  }

  Future ReportInsert(report user) async {
    await ReportTable.insert(user.toMap());
  }

  Future topLikeds(topLiked toplike) async {
    await Topliked.insert(toplike.toMap());
  }

  Future chatContents(userChat newChat) async {
    await ChatTable.insert(newChat.toMap());
  }

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

    print("INI agama ${agama}");

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
    // if (email != null) query = query.neq('Email', email);

    final response = await query;
    // print('HALOOOO ${response}');
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getUserDataByAutoFiltered({
    required int genderId, // 1 = female, 2 = male
    int? agama,
    int? hobi,
    int? angkatan,
    int? ethnic,
    int? zodiak,
    String? email,
    int? campusLocation,
    int? relation,
  }) async {
    print('Fetching filtered user data...');

    // print(email);

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
    if (campusLocation != null) query = query.eq('RegionID', campusLocation);
    if (relation != null) query = query.eq('LookingForID', relation);
    if (email != null) query = query.neq('Email', email);

    final response = await query;
    print('REGION ${campusLocation}');
    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<String> AlreadyLiked(String Email) async {
    final _supabase = Supabase.instance.client;

    final response = await _supabase
        .from("MaletoFemale")
        .select('Email_2')
        .eq('Email_1', Email);

    List<String> emails =
        response.map<String>((item) => item['Email_2'] as String).toList();

    return emails.join(', ');
  }

  Future<List<Map<String, dynamic>>> showTopLikes() async {
    final response = await Supabase.instance.client
        .from('TopLiked')
        .select('*, UserTable(*)')
        .order('likes', ascending: false);
    ;

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getSavedUserDataFemale({
    required String Email,
  }) async {
    final response = await Supabase.instance.client
        .from('FemaletoMale')
        .select('*, UserTable(*)')
        .eq('Email_1', Email);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getSavedUserDataMale({
    required String Email,
  }) async {
    final response = await Supabase.instance.client
        .from('MaletoFemale')
        .select('*, UserTable(*)')
        .eq('Email_1', Email);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> getSavedUserDataMaleChat({
    required String Email,
  }) async {
    final response = await Supabase.instance.client
        .from('FemaletoMaleChat')
        .select('*, UserTable(*)')
        .eq('Email_1', Email);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future updateValueString(String Value, String section, String Email) async {
    await Supabase.instance.client
        .from('UserTable')
        .update({section: Value}).eq("Email", Email);
  }

  Future updateValueInt(int Value, String section, String Email) async {
    await Supabase.instance.client
        .from('UserTable')
        .update({section: Value}).eq("Email", Email);
  }

  Future updateValueDouble(double Value, String section, String Email) async {
    await Supabase.instance.client
        .from('UserTable')
        .update({section: Value}).eq("Email", Email);
  }

  Future<List<Map<String, dynamic>>> getSavedUserDataFemaleChat({
    required String Email,
  }) async {
    final response = await Supabase.instance.client
        .from('MaletoFemaleChat')
        .select('*, UserTable(*)')
        .eq('Email_1', Email);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> showFullChat({
    required String user1,
    required String user2,
  }) async {
    final response = await Supabase.instance.client
        .from('ChatTable')
        .select('*')
        .or('and(Sender.eq.$user1,Receiver.eq.$user2),and(Sender.eq.$user2,Receiver.eq.$user1)');

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>?> getTopLiked(String email) async {
    final response = await Supabase.instance.client
        .from('TopLiked')
        .select('*')
        .eq('email', email)
        .maybeSingle();

    return response;
  }

  Future<Map<String, dynamic>?> getLikedEmailMale(
      String email1, String email2) async {
    // print("CEK EMAIL MASUK${email1}}");
    // print("CEK EMAIL MASUK${email2}}");

    final response = await Supabase.instance.client
        .from('FemaletoMale')
        .select('*')
        .eq('Email_1', email2)
        .eq('Email_2', email1)
        .maybeSingle();

    return response;
  }

  Future<Map<String, dynamic>?> getLikedEmailFemale(
      String email1, String email2) async {
    final response = await Supabase.instance.client
        .from('MaletoFemale')
        .select('*')
        .eq('Email_1', email2)
        .eq('Email_2', email1)
        .maybeSingle();

    return response;
  }
}
