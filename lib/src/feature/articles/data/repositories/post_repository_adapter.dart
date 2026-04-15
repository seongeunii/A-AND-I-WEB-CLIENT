import 'package:aandi_tech_blog/aandi_tech_blog.dart' as blog_api;
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/create_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/patch_post_payload.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_author.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/post_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/local_auth_datasource.dart';
import 'package:dio/dio.dart';

/// aandi_tech_blog 패키지를 게시글 Repository 인터페이스에 맞추는 구현체다.
final class PostRepositoryAdapter implements PostRepository {
  PostRepositoryAdapter({
    required blog_api.TechBlogApiClient client,
    required LocalAuthDatasource localAuthDatasource,
  })  : _client = client,
        _localAuthDatasource = localAuthDatasource;

  final blog_api.TechBlogApiClient _client;
  final LocalAuthDatasource _localAuthDatasource;

  @override
  Future<PostPage> getPosts({
    int page = 0,
    int size = 20,
    PostType? type,
    String? status,
  }) async {
    final response = await _client.listPostsV2(
      accessToken: await _resolveAccessToken(),
      page: page,
      size: size,
      status: _toBlogPostStatus(status),
      type: _toBlogPostType(type),
    );
    return _toPostPage(response);
  }

  @override
  Future<Post> createPost({
    required CreatePostPayload payload,
  }) async {
    final response = await _client.createPostV2(
      accessToken: await _resolveAccessToken(),
      post: blog_api.CreatePostRequest(
        title: payload.title,
        summary: payload.summary,
        contentMarkdown: payload.contentMarkdown,
        author: _toBlogAuthor(
          PostAuthor(
            id: payload.authorId,
            nickname: payload.authorNickname,
            profileImage: payload.authorProfileImageUrl,
          ),
        ),
        collaborators:
            payload.collaborators.map(_toBlogAuthor).toList(growable: false),
        type: _toBlogPostType(payload.type),
        status: _toBlogPostStatus(payload.status),
      ),
      thumbnail: _toMultipartFile(
        fileName: payload.imageFileName,
        bytes: payload.imageBytes,
      ),
    );

    return _toPost(response);
  }

  @override
  Future<Post> getPost({
    required String postId,
    required PostType type,
  }) async {
    final response = await _client.getPostV2(
      postId: postId,
      accessToken: await _resolveAccessToken(),
    );
    return _toPost(response);
  }

  @override
  Future<Post> patchPost({
    required String postId,
    required PatchPostPayload payload,
  }) async {
    final response = await _client.patchPostV2(
      postId: postId,
      accessToken: await _resolveAccessToken(),
      post: blog_api.PatchPostRequest(
        title: payload.title,
        summary: payload.summary,
        contentMarkdown: payload.contentMarkdown,
        collaborators:
            payload.collaborators.map(_toBlogAuthor).toList(growable: false),
        type: _toBlogPostType(payload.type),
        status: _toBlogPostStatus(payload.status),
      ),
      thumbnail: _toMultipartFile(
        fileName: payload.imageFileName,
        bytes: payload.imageBytes,
      ),
    );

    return _toPost(response);
  }

  @override
  Future<void> deletePost({
    required String postId,
  }) async {
    final accessToken = await _resolveAccessToken();
    try {
      await _client.deletePostV2(
        postId: postId,
        accessToken: accessToken,
      );
    } on DioException catch (error) {
      if (error.response?.statusCode != 403) {
        rethrow;
      }

      await _client.patchPostV2(
        postId: postId,
        accessToken: accessToken,
        post: blog_api.PatchPostRequest(
          status: blog_api.PostStatus.deleted,
        ),
      );
    }
  }

  @override
  Future<PostPage> getDraftPosts({
    int page = 0,
    int size = 20,
    PostType? type,
  }) async {
    final response = await _client.listMyDraftsV2(
      accessToken: await _resolveAccessToken(),
      page: page,
      size: size,
      type: _toBlogPostType(type),
    );
    return _toPostPage(response);
  }

  Future<String> _resolveAccessToken() async {
    final token = await _localAuthDatasource.getUserToken();
    final normalizedToken = token?.trim();
    if (normalizedToken == null || normalizedToken.isEmpty) {
      throw Exception('로그인이 필요합니다.');
    }
    if (normalizedToken.toLowerCase().startsWith('bearer ')) {
      return normalizedToken.substring('Bearer '.length).trim();
    }
    return normalizedToken;
  }
}

blog_api.PostAuthor _toBlogAuthor(PostAuthor author) {
  return blog_api.PostAuthor(
    id: author.id,
    nickname: author.nickname,
    profileImageUrl: author.profileImage,
  );
}

blog_api.PostType? _toBlogPostType(PostType? type) {
  return switch (type) {
    PostType.blog => blog_api.PostType.blog,
    PostType.lecture => blog_api.PostType.lecture,
    null => null,
  };
}

blog_api.PostStatus? _toBlogPostStatus(String? status) {
  final normalizedStatus = status?.trim();
  return switch (normalizedStatus) {
    'Draft' => blog_api.PostStatus.draft,
    'Published' => blog_api.PostStatus.published,
    'Deleted' => blog_api.PostStatus.deleted,
    _ => null,
  };
}

PostPage _toPostPage(blog_api.PagedPostResponse response) {
  return PostPage(
    items: response.items.map(_toPost).toList(growable: false),
    page: response.page,
    size: response.size,
    totalElements: response.totalElements,
    totalPages: response.totalPages,
  );
}

Post _toPost(blog_api.PostResponse response) {
  final author = response.author;
  return Post(
    id: response.id,
    type: switch (response.type ?? blog_api.PostType.blog) {
      blog_api.PostType.blog => PostType.blog,
      blog_api.PostType.lecture => PostType.lecture,
    },
    title: response.title,
    contentMarkdown: response.contentMarkdown ?? '',
    summary: response.summary,
    thumbnailUrl: response.thumbnailUrl,
    author: PostAuthor(
      id: author.id,
      nickname: author.nickname?.trim().isNotEmpty == true
          ? author.nickname!
          : author.id,
      profileImage: author.profileImageUrl,
    ),
    collaborators: response.collaborators
        .map(
          (author) => PostAuthor(
            id: author.id,
            nickname: author.nickname?.trim().isNotEmpty == true
                ? author.nickname!
                : author.id,
            profileImage: author.profileImageUrl,
          ),
        )
        .toList(growable: false),
    status: response.status.toApi(),
    createdAt: response.createdAt ??
        response.updatedAt ??
        DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: response.updatedAt ??
        response.createdAt ??
        DateTime.fromMillisecondsSinceEpoch(0),
  );
}

MultipartFile? _toMultipartFile({
  required String? fileName,
  required List<int>? bytes,
}) {
  if (bytes == null || bytes.isEmpty) {
    return null;
  }
  if (fileName == null || fileName.isEmpty) {
    return null;
  }
  return MultipartFile.fromBytes(
    bytes,
    filename: fileName,
  );
}
