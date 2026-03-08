import 'dart:typed_data';

import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';

/// 게시글 수정 요청 페이로드입니다.
class PatchPostPayload {
  /// 게시글 수정 요청 페이로드를 생성합니다.
  const PatchPostPayload({
    this.title,
    this.contentMarkdown,
    this.summary,
    this.status,
    this.collaborators = const <PostAuthor>[],
    this.imageFileName,
    this.imageBytes,
  });

  /// 게시글 제목입니다.
  final String? title;

  /// 게시글 본문(Markdown)입니다.
  final String? contentMarkdown;

  /// 게시글 요약입니다.
  final String? summary;

  /// 게시글 상태입니다. (예: Draft, Published, Deleted)
  final String? status;

  /// 공동 작업자 목록입니다.
  final List<PostAuthor> collaborators;

  /// 첨부 이미지 파일명입니다.
  final String? imageFileName;

  /// 첨부 이미지 바이트입니다.
  final Uint8List? imageBytes;
}
