import 'package:a_and_i_report_web_server/src/feature/articles/data/datasources/post_remote_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_author_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_list_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/dtos/post_response_dto.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/post_repository_impl.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/create_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/patch_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostRepositoryImpl', () {
    test('getPosts는 목록 DTO를 PostPage로 매핑하고 인자를 전달한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.getPosts(
        page: 2,
        size: 50,
        status: 'Published',
      );

      expect(datasource.getPostsPage, 2);
      expect(datasource.getPostsSize, 50);
      expect(datasource.getPostsStatus, 'Published');
      expect(result.page, 2);
      expect(result.size, 50);
      expect(result.totalElements, 120);
      expect(result.totalPages, 3);
      expect(result.items.length, 1);
      expect(result.items.first.id, 'post-1');
      expect(result.items.first.status, 'Published');
      expect(result.items.first.author.id, 'author-id-1');
      expect(result.items.first.author.nickname, 'author-1');
      expect(result.items.first.collaborators.length, 1);
      expect(result.items.first.collaborators.first.id, 'collaborator-id-1');
      expect(result.items.first.collaborators.first.nickname, 'collaborator-1');
    });

    test('createPost는 payload를 DTO로 변환하고 Post를 반환한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.createPost(
        payload: const CreatePostPayload(
          type: PostType.blog,
          title: '새 글',
          contentMarkdown: '# hello',
          summary: '요약',
          authorId: 'author-1',
          authorNickname: '멘토',
          authorProfileImageUrl: 'https://example.com/profile.png',
          status: 'Draft',
        ),
      );

      expect(datasource.createTitle, '새 글');
      expect(datasource.createContentMarkdown, '# hello');
      expect(datasource.createSummary, '요약');
      expect(datasource.createAuthorId, 'author-1');
      expect(datasource.createAuthorNickname, '멘토');
      expect(datasource.createAuthorProfileImageUrl,
          'https://example.com/profile.png');
      expect(datasource.createType, PostType.blog);
      expect(datasource.createStatus, 'Draft');
      expect(datasource.createCollaborators, isEmpty);
      expect(datasource.createFile, isNull);
      expect(datasource.createAuthorization, 'Bearer token');
      expect(result.id, 'post-1');
    });

    test('getPost는 postId를 전달하고 상세를 반환한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.getPost(
        postId: 'post-xyz',
        type: PostType.blog,
      );

      expect(datasource.getPostId, 'post-xyz');
      expect(datasource.getPostAuthorization, 'Bearer token');
      expect(result.id, 'post-1');
      expect(result.title, 'title');
    });

    test('patchPost는 payload를 DTO로 변환하고 결과를 반환한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.patchPost(
        postId: 'post-xyz',
        payload: const PatchPostPayload(
          title: '수정 제목',
          contentMarkdown: '수정 본문',
          summary: '수정 요약',
          status: 'Published',
        ),
      );

      expect(datasource.patchAuthorization, 'Bearer token');
      expect(datasource.patchPostId, 'post-xyz');
      expect(datasource.patchTitle, '수정 제목');
      expect(datasource.patchContentMarkdown, '수정 본문');
      expect(datasource.patchSummary, '수정 요약');
      expect(datasource.patchStatus, 'Published');
      expect(datasource.patchCollaborators, isEmpty);
      expect(datasource.patchFile, isNull);
      expect(result.id, 'post-1');
    });

    test('deletePost는 postId를 전달한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      await repository.deletePost(
        postId: 'post-delete',
      );

      expect(datasource.deleteAuthorization, 'Bearer token');
      expect(datasource.deletePostId, 'post-delete');
    });

    test('deletePost에서 403이 발생하면 status=Deleted로 soft delete를 시도한다', () async {
      final datasource = FakePostRemoteDatasource()
        ..deleteException = DioException(
          requestOptions: RequestOptions(path: '/v1/posts/post-delete'),
          response: Response<void>(
            requestOptions: RequestOptions(path: '/v1/posts/post-delete'),
            statusCode: 403,
          ),
          type: DioExceptionType.badResponse,
        );
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      await repository.deletePost(postId: 'post-delete');

      expect(datasource.deleteAuthorization, 'Bearer token');
      expect(datasource.deletePostId, 'post-delete');
      expect(datasource.patchAuthorization, 'Bearer token');
      expect(datasource.patchPostId, 'post-delete');
      expect(datasource.patchStatus, 'Deleted');
    });

    test('getDraftPosts는 draft 목록 DTO를 PostPage로 매핑한다', () async {
      final datasource = FakePostRemoteDatasource();
      final localAuthDatasource = FakeLocalAuthDatasource();
      final repository = PostRepositoryImpl(
        postRemoteDatasource: datasource,
        localAuthDatasource: localAuthDatasource,
      );

      final result = await repository.getDraftPosts(
        page: 1,
        size: 10,
      );

      expect(datasource.getDraftsAuthorization, 'Bearer token');
      expect(datasource.getDraftsPage, 1);
      expect(datasource.getDraftsSize, 10);
      expect(result.items.first.status, 'Draft');
    });
  });
}

class FakeLocalAuthDatasource implements LocalAuthDatasource {
  @override
  Future<void> deleteCachedUserJson() async {}

  @override
  Future<void> deleteRefreshToken() async {}

  @override
  Future<void> deleteUserToken() async {}

  @override
  Future<String?> getCachedUserJson() async {
    return null;
  }

  @override
  Future<String?> getRefreshToken() async {
    return null;
  }

  @override
  Future<String?> getUserToken() async {
    return 'token';
  }

  @override
  Future<void> saveCachedUserJson(String userJson) async {}

  @override
  Future<void> saveRefreshToken(String token) async {}

  @override
  Future<void> saveUserToken(String token) async {}
}

class FakePostRemoteDatasource implements PostRemoteDatasource {
  String? getPostsAuthorization;
  int? getPostsPage;
  int? getPostsSize;
  String? getPostsStatus;
  PostType? getPostsType;
  int? getDraftsPage;
  int? getDraftsSize;
  PostType? getDraftsType;
  String? getPostAuthorization;
  String? getPostId;
  String? patchPostId;
  String? deletePostId;
  String? createAuthorization;
  String? patchAuthorization;
  String? deleteAuthorization;
  String? getDraftsAuthorization;
  String? createTitle;
  String? createContentMarkdown;
  String? createSummary;
  String? createAuthorId;
  String? createAuthorNickname;
  String? createAuthorProfileImageUrl;
  PostType? createType;
  String? createStatus;
  List<PostAuthor> createCollaborators = <PostAuthor>[];
  DioException? deleteException;
  MultipartFile? createFile;
  String? patchTitle;
  String? patchContentMarkdown;
  String? patchSummary;
  String? patchStatus;
  List<PostAuthor> patchCollaborators = <PostAuthor>[];
  MultipartFile? patchFile;

  @override
  Future<PostResponseDto> createPost(
    String authorization,
    String title,
    String contentMarkdown,
    PostType type,
    String? summary,
    String authorId,
    String authorNickname,
    String? authorProfileImageUrl,
    String? status,
    List<PostAuthor> collaborators,
    MultipartFile? file,
  ) async {
    createAuthorization = authorization;
    createTitle = title;
    createContentMarkdown = contentMarkdown;
    createType = type;
    createSummary = summary;
    createAuthorId = authorId;
    createAuthorNickname = authorNickname;
    createAuthorProfileImageUrl = authorProfileImageUrl;
    createStatus = status;
    createCollaborators = collaborators;
    createFile = file;
    return _samplePost(status: status ?? 'Draft');
  }

  @override
  Future<void> deletePost(String authorization, String postId) async {
    deleteAuthorization = authorization;
    deletePostId = postId;
    if (deleteException != null) {
      throw deleteException!;
    }
  }

  @override
  Future<PostListResponseDto> getDraftPosts(
    String authorization,
    int page,
    int size,
    PostType? type,
  ) async {
    getDraftsAuthorization = authorization;
    getDraftsPage = page;
    getDraftsSize = size;
    getDraftsType = type;
    return PostListResponseDto(
      items: [_sampleDraftPost()],
      page: page,
      size: size,
      totalElements: 1,
      totalPages: 1,
    );
  }

  @override
  Future<PostResponseDto> getPost(String authorization, String postId) async {
    getPostAuthorization = authorization;
    getPostId = postId;
    return _samplePost(status: 'Published');
  }

  @override
  Future<PostListResponseDto> getPosts(
    String authorization,
    int page,
    int size,
    PostType? type,
    String? status,
  ) async {
    getPostsAuthorization = authorization;
    getPostsPage = page;
    getPostsSize = size;
    getPostsType = type;
    getPostsStatus = status;
    return PostListResponseDto(
      items: [_samplePublishedPost()],
      page: page,
      size: size,
      totalElements: 120,
      totalPages: 3,
    );
  }

  @override
  Future<PostResponseDto> patchPost(
    String authorization,
    String postId,
    PostType? type,
    String? title,
    String? contentMarkdown,
    String? summary,
    String? status,
    List<PostAuthor> collaborators,
    MultipartFile? file,
  ) async {
    patchAuthorization = authorization;
    patchPostId = postId;
    patchTitle = title;
    patchContentMarkdown = contentMarkdown;
    patchSummary = summary;
    patchStatus = status;
    patchCollaborators = collaborators;
    patchFile = file;
    return _samplePost(status: status ?? 'Draft');
  }
}

PostResponseDto _samplePost({
  required String status,
}) {
  return PostResponseDto(
    id: 'post-1',
    type: 'Blog',
    title: 'title',
    contentMarkdown: 'content',
    summary: '요약',
    thumbnailUrl: 'https://example.com/thumbnail.webp',
    author: const PostAuthorResponseDto(
      id: 'author-id-1',
      nickname: 'author-1',
      profileImage: 'https://example.com/profile.png',
    ),
    collaborators: const <PostAuthorResponseDto>[
      PostAuthorResponseDto(
        id: 'collaborator-id-1',
        nickname: 'collaborator-1',
        profileImage: 'https://example.com/collaborator.png',
      ),
    ],
    status: status,
    createdAt: DateTime.parse('2026-02-01T00:00:00Z'),
    updatedAt: DateTime.parse('2026-02-02T00:00:00Z'),
  );
}

PostResponseDto _samplePublishedPost() {
  return _samplePost(status: 'Published');
}

PostResponseDto _sampleDraftPost() {
  return _samplePost(status: 'Draft');
}
