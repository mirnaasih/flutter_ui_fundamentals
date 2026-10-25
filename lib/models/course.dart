// ni komang mirna asih
// 2415051018

class Course {
  final int? id; 
  final String code;
  final String title;
  final int credits;
  final String status;
  final String category;
  final bool isFavorite;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned', 
    required this.category,
    this.isFavorite = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      credits: json['credits'] as int? ?? 0,
      status: (json['status'] as String?) ?? 'planned',
      category: json['category'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  // Method toJson() yang wajib ditambahkan di Tahap 3
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'title': title,
        'credits': credits,
        'status': status,
        'category': category,
        'isFavorite': isFavorite,
      };
}