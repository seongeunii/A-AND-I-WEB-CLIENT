// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_course_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminCourseListViewModelHash() =>
    r'828eb04132c3fed791ab6532198d58ef20da1c4f';

/// 관리자용 전체 코스 목록을 조회하는 ViewModel입니다.
///
/// Copied from [AdminCourseListViewModel].
@ProviderFor(AdminCourseListViewModel)
final adminCourseListViewModelProvider = AutoDisposeAsyncNotifierProvider<
    AdminCourseListViewModel, List<Course>>.internal(
  AdminCourseListViewModel.new,
  name: r'adminCourseListViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$adminCourseListViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AdminCourseListViewModel = AutoDisposeAsyncNotifier<List<Course>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
