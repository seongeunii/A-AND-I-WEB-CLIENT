/// Retrofit 어노테이션과 공통 상수에서 재사용하는 API 템플릿 집합이다.
final class AandiApiEndpointTemplate {
  const AandiApiEndpointTemplate._();

  /// 로그인 엔드포인트다.
  static const String login = '/v2/auth/login';

  /// 토큰 재발급 엔드포인트다.
  static const String refreshToken = '/v2/auth/refresh';

  /// 로그아웃 엔드포인트다.
  static const String logout = '/v2/auth/logout';

  /// 내 정보 조회/수정 엔드포인트다.
  static const String me = '/v2/me';

  /// 내 비밀번호 변경 엔드포인트다.
  static const String mePassword = '/v2/me/password';

  /// 계정 활성화 엔드포인트 후보 목록이다.
  static const List<String> activateCandidates = <String>[
    '/v2/activate',
    '/activate',
  ];

  /// 사용자 공개 코드 조회 엔드포인트다.
  static const String userLookup = '/v2/users/lookup';

  /// 게시글 목록/생성 엔드포인트다.
  static const String posts = '/v2/posts';

  /// 초안 게시글 목록 엔드포인트다.
  static const String draftPosts = '/v2/posts/drafts';

  /// 내 게시글 목록 엔드포인트다.
  static const String myPosts = '/v2/posts/me';

  /// 내 초안 게시글 목록 엔드포인트다.
  static const String myDraftPosts = '/v2/posts/drafts/me';

  /// 게시글 상세 템플릿이다.
  static const String postById = '/v2/posts/{postId}';

  /// 게시글 협업자 추가 템플릿이다.
  static const String postCollaborators = '/v2/posts/{postId}/collaborators';

  /// 게시글 이미지 업로드 엔드포인트다.
  static const String postImages = '/v2/posts/images';

  /// OJ 테스트케이스 목록 엔드포인트다.
  static const String adminTestCasesV2 = '/v2/admin/testcases';

  /// OJ 제출 목록 엔드포인트다.
  static const String adminSubmissionsV2 = '/v2/admin/submissions';

  /// 코스 목록 엔드포인트다.
  static const String courses = '/v2/courses';

  /// 코스 상세 템플릿이다.
  static const String courseBySlug = '/v2/courses/{courseSlug}';

  /// 코스 목차 템플릿이다.
  static const String courseOutline = '/v2/courses/{courseSlug}/outline';

  /// 코스 주차별 과제 목록 템플릿이다.
  static const String courseWeekAssignments =
      '/v2/courses/{courseSlug}/weeks/{weekNo}/assignments';

  /// 코스 과제 상세 템플릿이다.
  static const String courseAssignmentDetail =
      '/v2/courses/{courseSlug}/assignments/{assignmentId}';

  /// 제출 생성 엔드포인트다.
  static const String submissions = '/v2/submissions';

  /// 제출 상세 템플릿이다.
  static const String submissionById = '/v2/submissions/{submissionId}';

  /// 특정 문제의 내 제출 목록 템플릿이다.
  static const String myProblemSubmissions =
      '/v2/problems/{problemId}/submissions/me';

  /// 관리자 코스 목록 엔드포인트다.
  static const String adminCoursesV2 = '/v2/admin/courses';

  /// 공개 코스 목록 엔드포인트다.
  static const String coursesV2 = '/v2/courses';

  /// 과제 기준 코스 조회 템플릿이다.
  static const String assignmentCourseV2 =
      '/v2/assignments/{assignmentId}/course';

  /// 공개 코스 상세 템플릿이다.
  static const String courseBySlugV2 = '/v2/courses/{courseSlug}';

  /// 공개 코스 주차 목록 템플릿이다.
  static const String courseWeeksV2 = '/v2/courses/{courseSlug}/weeks';

  /// 공개 코스 주차별 과제 템플릿이다.
  static const String courseWeekAssignmentsV2 =
      '/v2/courses/{courseSlug}/weeks/{weekNo}/assignments';

  /// 공개 코스 목차 템플릿이다.
  static const String courseOutlineV2 = '/v2/courses/{courseSlug}/outline';

  /// 공개 코스 과제 목록 템플릿이다.
  static const String courseAssignmentsV2 =
      '/v2/courses/{courseSlug}/assignments';

  /// 공개 코스 과제 상세 템플릿이다.
  static const String courseAssignmentByIdV2 =
      '/v2/courses/{courseSlug}/assignments/{assignmentId}';

  /// 관리자 코스 등록 목록 템플릿이다.
  static const String adminCourseEnrollmentsV2 =
      '/v2/admin/courses/{courseSlug}/enrollments';

  /// 관리자 코스 등록 사용자 템플릿이다.
  static const String adminCourseEnrollmentByUserV2 =
      '/v2/admin/courses/{courseSlug}/enrollments/{userId}';

  /// 관리자 코스 과제 목록 템플릿이다.
  static const String adminCourseAssignmentsV2 =
      '/v2/admin/courses/{courseSlug}/assignments';

  /// 관리자 코스 과제 상세 템플릿이다.
  static const String adminCourseAssignmentByIdV2 =
      '/v2/admin/courses/{courseSlug}/assignments/{assignmentId}';

  /// 관리자 코스 과제 제출 현황 템플릿이다.
  static const String adminCourseAssignmentSubmissionStatusesV2 =
      '/v2/admin/courses/{courseSlug}/assignments/{assignmentId}/submission-statuses';
}
