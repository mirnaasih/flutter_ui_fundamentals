// ni komang mirna asih
// 2415051018

class Course {
  final int? id;
  final String code;
  final String title;
  final int credits;
  final String status;

  Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? ''),
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      credits: json['credits'] is int ? json['credits'] : int.tryParse(json['credits']?.toString() ?? '0') ?? 0,
      status: json['status'] ?? 'planned',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'credits': credits,
      'status': status,
    };
  }
}