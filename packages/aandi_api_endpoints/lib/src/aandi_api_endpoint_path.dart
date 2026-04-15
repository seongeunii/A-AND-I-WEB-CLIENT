/// 런타임에서 사용하는 실제 API 경로 빌더다.
final class AandiApiEndpointPath {
  const AandiApiEndpointPath._();

  /// 게시글 상세 경로를 반환한다.
  static String postById(String postId) => '/v2/posts/$postId';

  /// 게시글 협업자 추가 경로를 반환한다.
  static String postCollaborators(String postId) =>
      '/v2/posts/$postId/collaborators';

  /// 제출 상세 경로를 반환한다.
  static String submissionById(String submissionId) =>
      '/v2/submissions/$submissionId';

  /// 특정 문제의 내 제출 목록 경로를 반환한다.
  static String myProblemSubmissions(String problemId) =>
      '/v2/problems/$problemId/submissions/me';

  /// 코스 상세 경로를 반환한다.
  static String courseBySlug(String courseSlug) => '/v2/courses/$courseSlug';

  /// 코스 목차 경로를 반환한다.
  static String courseOutline(String courseSlug) =>
      '/v2/courses/$courseSlug/outline';

  /// 코스 주차별 과제 경로를 반환한다.
  static String courseWeekAssignments(String courseSlug, int weekNo) =>
      '/v2/courses/$courseSlug/weeks/$weekNo/assignments';

  /// 코스 과제 상세 경로를 반환한다.
  static String courseAssignmentDetail(
    String courseSlug,
    String assignmentId,
  ) =>
      '/v2/courses/$courseSlug/assignments/$assignmentId';

  /// 과제 기준 코스 조회 경로를 반환한다.
  static String assignmentCourseV2(String assignmentId) =>
      '/v2/assignments/$assignmentId/course';

  /// 공개 코스 상세 경로를 반환한다.
  static String courseBySlugV2(String courseSlug) => '/v2/courses/$courseSlug';

  /// 공개 코스 주차 목록 경로를 반환한다.
  static String courseWeeksV2(String courseSlug) =>
      '/v2/courses/$courseSlug/weeks';

  /// 공개 코스 주차별 과제 경로를 반환한다.
  static String courseWeekAssignmentsV2(String courseSlug, int weekNo) =>
      '/v2/courses/$courseSlug/weeks/$weekNo/assignments';

  /// 공개 코스 목차 경로를 반환한다.
  static String courseOutlineV2(String courseSlug) =>
      '/v2/courses/$courseSlug/outline';

  /// 공개 코스 과제 목록 경로를 반환한다.
  static String courseAssignmentsV2(String courseSlug) =>
      '/v2/courses/$courseSlug/assignments';

  /// 공개 코스 과제 상세 경로를 반환한다.
  static String courseAssignmentByIdV2(
          String courseSlug, String assignmentId) =>
      '/v2/courses/$courseSlug/assignments/$assignmentId';

  /// 관리자 코스 등록 목록 경로를 반환한다.
  static String adminCourseEnrollmentsV2(String courseSlug) =>
      '/v2/admin/courses/$courseSlug/enrollments';

  /// 관리자 코스 등록 사용자 경로를 반환한다.
  static String adminCourseEnrollmentByUserV2(
    String courseSlug,
    String userId,
  ) =>
      '/v2/admin/courses/$courseSlug/enrollments/$userId';

  /// 관리자 코스 과제 목록 경로를 반환한다.
  static String adminCourseAssignmentsV2(String courseSlug) =>
      '/v2/admin/courses/$courseSlug/assignments';

  /// 관리자 코스 과제 상세 경로를 반환한다.
  static String adminCourseAssignmentByIdV2(
    String courseSlug,
    String assignmentId,
  ) =>
      '/v2/admin/courses/$courseSlug/assignments/$assignmentId';

  /// 관리자 코스 과제 제출 현황 경로를 반환한다.
  static String adminCourseAssignmentSubmissionStatusesV2(
    String courseSlug,
    String assignmentId,
  ) =>
      '/v2/admin/courses/$courseSlug/assignments/$assignmentId/submission-statuses';
}
