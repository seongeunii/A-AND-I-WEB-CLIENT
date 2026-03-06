/// 코스 주차 응답 DTO입니다.
class CourseWeekDto {
  final String id;
  final int weekNo;
  final String title;
  final String startDate;
  final String endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseWeekDto({
    required this.id,
    required this.weekNo,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseWeekDto.fromJson(Map<String, dynamic> json) {
    return CourseWeekDto(
      id: json['id'] as String,
      weekNo: (json['weekNo'] as num).toInt(),
      title: json['title'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
