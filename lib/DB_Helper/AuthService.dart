import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Future<String?> getUserIdByEmail(String email) async {
  //   final response =
  //       await _supabase.rpc('get_user_id_by_email', params: {'email': email});
  //   print("User ID: $response");

  //   return response;
  // }

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    final response = await Supabase.instance.client
        .from('UserTable')
        .select(
            '*, Region(*), Looking_For(*), Gender(*), Angkatan(*), Agama(*), Hobi(*), Zodiak(*), Ethnic(*)')
        .eq('Email', email)
        .single();

    return response;
  }
}
