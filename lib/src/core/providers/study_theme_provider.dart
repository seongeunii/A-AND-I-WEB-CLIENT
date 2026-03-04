import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 스터디 라우트(`/course`, `/report`, `/report/:id`)에서 공유하는 다크모드 상태입니다.
final studyDarkModeProvider = StateProvider<bool>((ref) => false);
