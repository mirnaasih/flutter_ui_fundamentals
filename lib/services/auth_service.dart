import 'package:supabase_flutter/supabase_flutter.dart';

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

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email.trim(),
      password: password,
    );
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

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}