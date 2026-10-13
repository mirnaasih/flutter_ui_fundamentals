// ni komang mirna asih
// 2415051018

class Course {
  final String code;
  final String title;
  final int credits;
  final String status;
  final String category;
  final bool isFavorite;

  Course({
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
    required this.category,
    this.isFavorite = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: json['credits'] as int? ?? 0,
      status: json['status'] as String? ?? 'pending',
      category: json['category'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}