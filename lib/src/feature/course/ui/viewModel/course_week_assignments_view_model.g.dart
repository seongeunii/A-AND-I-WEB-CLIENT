// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_week_assignments_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseWeekAssignmentsViewModelHash() =>
    r'4f3e432553406132d49c02769b38f56d1e3d0de1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 코스 주차별 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeekAssignmentsViewModel].
@ProviderFor(courseWeekAssignmentsViewModel)
const courseWeekAssignmentsViewModelProvider =
    CourseWeekAssignmentsViewModelFamily();

/// 코스 주차별 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeekAssignmentsViewModel].
class CourseWeekAssignmentsViewModelFamily
    extends Family<AsyncValue<List<CourseAssignment>>> {
  /// 코스 주차별 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeekAssignmentsViewModel].
  const CourseWeekAssignmentsViewModelFamily();

  /// 코스 주차별 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeekAssignmentsViewModel].
  CourseWeekAssignmentsViewModelProvider call(
    CourseWeekAssignmentsQuery query,
  ) {
    return CourseWeekAssignmentsViewModelProvider(
      query,
    );
  }

  @override
  CourseWeekAssignmentsViewModelProvider getProviderOverride(
    covariant CourseWeekAssignmentsViewModelProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseWeekAssignmentsViewModelProvider';
}

/// 코스 주차별 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeekAssignmentsViewModel].
class CourseWeekAssignmentsViewModelProvider
    extends AutoDisposeFutureProvider<List<CourseAssignment>> {
  /// 코스 주차별 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeekAssignmentsViewModel].
  CourseWeekAssignmentsViewModelProvider(
    CourseWeekAssignmentsQuery query,
  ) : this._internal(
          (ref) => courseWeekAssignmentsViewModel(
            ref as CourseWeekAssignmentsViewModelRef,
            query,
          ),
          from: courseWeekAssignmentsViewModelProvider,
          name: r'courseWeekAssignmentsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseWeekAssignmentsViewModelHash,
          dependencies: CourseWeekAssignmentsViewModelFamily._dependencies,
          allTransitiveDependencies:
              CourseWeekAssignmentsViewModelFamily._allTransitiveDependencies,
          query: query,
        );

  CourseWeekAssignmentsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final CourseWeekAssignmentsQuery query;

  @override
  Override overrideWith(
    FutureOr<List<CourseAssignment>> Function(
            CourseWeekAssignmentsViewModelRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseWeekAssignmentsViewModelProvider._internal(
        (ref) => create(ref as CourseWeekAssignmentsViewModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CourseAssignment>> createElement() {
    return _CourseWeekAssignmentsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseWeekAssignmentsViewModelProvider &&
        other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseWeekAssignmentsViewModelRef
    on AutoDisposeFutureProviderRef<List<CourseAssignment>> {
  /// The parameter `query` of this provider.
  CourseWeekAssignmentsQuery get query;
}

class _CourseWeekAssignmentsViewModelProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseAssignment>>
    with CourseWeekAssignmentsViewModelRef {
  _CourseWeekAssignmentsViewModelProviderElement(super.provider);

  @override
  CourseWeekAssignmentsQuery get query =>
      (origin as CourseWeekAssignmentsViewModelProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
