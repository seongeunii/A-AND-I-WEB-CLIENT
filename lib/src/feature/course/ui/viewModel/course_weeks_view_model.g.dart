// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_weeks_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseWeeksViewModelHash() =>
    r'b5c5768cfc1510ec053317ee6f9d6085e7898ee2';

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

/// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeeksViewModel].
@ProviderFor(courseWeeksViewModel)
const courseWeeksViewModelProvider = CourseWeeksViewModelFamily();

/// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeeksViewModel].
class CourseWeeksViewModelFamily extends Family<AsyncValue<List<CourseWeek>>> {
  /// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeeksViewModel].
  const CourseWeeksViewModelFamily();

  /// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeeksViewModel].
  CourseWeeksViewModelProvider call(
    String courseSlug,
  ) {
    return CourseWeeksViewModelProvider(
      courseSlug,
    );
  }

  @override
  CourseWeeksViewModelProvider getProviderOverride(
    covariant CourseWeeksViewModelProvider provider,
  ) {
    return call(
      provider.courseSlug,
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
  String? get name => r'courseWeeksViewModelProvider';
}

/// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
///
/// Copied from [courseWeeksViewModel].
class CourseWeeksViewModelProvider
    extends AutoDisposeFutureProvider<List<CourseWeek>> {
  /// 코스 슬러그 기반 주차 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseWeeksViewModel].
  CourseWeeksViewModelProvider(
    String courseSlug,
  ) : this._internal(
          (ref) => courseWeeksViewModel(
            ref as CourseWeeksViewModelRef,
            courseSlug,
          ),
          from: courseWeeksViewModelProvider,
          name: r'courseWeeksViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseWeeksViewModelHash,
          dependencies: CourseWeeksViewModelFamily._dependencies,
          allTransitiveDependencies:
              CourseWeeksViewModelFamily._allTransitiveDependencies,
          courseSlug: courseSlug,
        );

  CourseWeeksViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseSlug,
  }) : super.internal();

  final String courseSlug;

  @override
  Override overrideWith(
    FutureOr<List<CourseWeek>> Function(CourseWeeksViewModelRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseWeeksViewModelProvider._internal(
        (ref) => create(ref as CourseWeeksViewModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseSlug: courseSlug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CourseWeek>> createElement() {
    return _CourseWeeksViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseWeeksViewModelProvider &&
        other.courseSlug == courseSlug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseSlug.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseWeeksViewModelRef
    on AutoDisposeFutureProviderRef<List<CourseWeek>> {
  /// The parameter `courseSlug` of this provider.
  String get courseSlug;
}

class _CourseWeeksViewModelProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseWeek>>
    with CourseWeeksViewModelRef {
  _CourseWeeksViewModelProviderElement(super.provider);

  @override
  String get courseSlug => (origin as CourseWeeksViewModelProvider).courseSlug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
