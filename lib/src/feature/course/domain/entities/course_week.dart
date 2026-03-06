/// 코스 주차 정보를 표현하는 엔티티입니다.
class CourseWeek {
  final String id;
  final int weekNo;
  final String title;
  final String startDate;
  final String endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CourseWeek({
    required this.id,
    required this.weekNo,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
}
