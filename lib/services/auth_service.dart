// ni komang mirna asih
// 2415051018

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  Session? get currentSession => _client.auth.currentSession;
  User? get currentUser => _client.auth.currentUser;

  bool get hasValidSession {
    final session = currentSession;
    if (session == null || _client.auth.currentUser == null) {
      return false;
    }
    final expiresAt = session.expiresAt;
    if (expiresAt == null) return true;
    final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return expiresAt > nowInSeconds;
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    final response = await _client.auth.signUp(
      email: email.trim(),
      password: password,
    );

    final user = response.user;
    if (user != null) {
      await _client.from('profiles').upsert({
        'id': user.id,
        'email': email.trim(),
        'name': name.trim(),
        'role': role,
      });
    }

    return response;
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserProfile?> getCurrentProfile() async {
    final user = currentUser;
    if (user == null) return null;

    final data = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (data == null) return null;
    return UserProfile.fromMap(data);
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}