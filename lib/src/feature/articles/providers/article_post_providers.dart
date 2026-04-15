import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:aandi_tech_blog/aandi_tech_blog.dart' as blog_api;
import 'package:a_and_i_report_web_server/src/core/constants/api_url.dart';
import 'package:a_and_i_report_web_server/src/core/providers/dio_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/collaborator_lookup_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/image_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/data/repositories/post_repository_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_page.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/entities/post_type.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/data/datasources/local/auth_token_store_adapter.dart';
import 'package:a_and_i_report_web_server/src/feature/auth/providers/local_auth_datasource_provider.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/collaborator_lookup_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/image_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/repositories/post_repository.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/usecases/get_my_draft_posts_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/usecases/get_post_list_usecase.dart';
import 'package:a_and_i_report_web_server/src/feature/articles/domain/usecases/lookup_collaborator_by_code_usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 게시글 조회 저장소 Provider입니다.
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryAdapter(
    client: blog_api.TechBlogApiClient(
      baseUrl: baseUrl,
      dio: ref.read(dioProvider),
    ),
    localAuthDatasource: ref.read(localAuthDatasourceProvider),
  );
});

/// 이미지 업로드 저장소 Provider입니다.
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepositoryAdapter(
    client: blog_api.TechBlogApiClient(
      baseUrl: baseUrl,
      dio: ref.read(dioProvider),
    ),
    localAuthDatasource: ref.read(localAuthDatasourceProvider),
  );
});

/// 협업자 조회 저장소 Provider입니다.
final collaboratorLookupRepositoryProvider =
    Provider<CollaboratorLookupRepository>((ref) {
  return CollaboratorLookupRepositoryAdapter(
    repository: auth_api.AuthRepositoryImpl(
      apiClient: auth_api.AuthApiClient(baseUrl: baseUrl),
      tokenStore: AuthTokenStoreAdapter(
        localAuthDatasource: ref.read(localAuthDatasourceProvider),
      ),
    ),
    localAuthDatasource: ref.read(localAuthDatasourceProvider),
  );
});

/// 게시글 목록 조회 유스케이스 Provider입니다.
final getPostListUsecaseProvider = Provider<GetPostListUsecase>((ref) {
  return GetPostListUsecase(ref.read(postRepositoryProvider));
});

/// 내 임시저장 게시글 목록 조회 유스케이스 Provider입니다.
final getMyDraftPostsUsecaseProvider = Provider<GetMyDraftPostsUsecase>((ref) {
  return GetMyDraftPostsUsecase(ref.read(postRepositoryProvider));
});

/// 공개 코드 협업자 조회 유스케이스 Provider입니다.
final lookupCollaboratorByCodeUsecaseProvider =
    Provider<LookupCollaboratorByCodeUsecase>((ref) {
  return LookupCollaboratorByCodeUsecase(
    ref.read(collaboratorLookupRepositoryProvider),
  );
});

/// 내 임시저장 게시글 목록 조회 Provider입니다.
final myDraftPostPageProvider =
    FutureProvider.autoDispose<PostPage>((ref) async {
  final draftPages = await Future.wait<PostPage>([
    ref.read(getMyDraftPostsUsecaseProvider).call(
          page: 0,
          size: 100,
          type: PostType.blog,
        ),
    ref.read(getMyDraftPostsUsecaseProvider).call(
          page: 0,
          size: 100,
          type: PostType.lecture,
        ),
  ]);

  final items = <Post>[
    ...draftPages[0].items,
    ...draftPages[1].items,
  ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  return PostPage(
    items: items,
    page: 0,
    size: items.length,
    totalElements: items.length,
    totalPages: 1,
  );
});
