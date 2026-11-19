// ni komang mirna asih
// 2415051018

class UserProfile {
  final String id;
  final String email;
  final String name;
  final String role;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] as String,
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      role: map['role'] as String? ?? 'mahasiswa',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
    };
  }
}