// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseDetailViewModelHash() =>
    r'c28c6ddc3b458600e83a8ca317551838481fa2e0';

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

/// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
///
/// Copied from [courseDetailViewModel].
@ProviderFor(courseDetailViewModel)
const courseDetailViewModelProvider = CourseDetailViewModelFamily();

/// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
///
/// Copied from [courseDetailViewModel].
class CourseDetailViewModelFamily extends Family<AsyncValue<CourseDetail?>> {
  /// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
  ///
  /// Copied from [courseDetailViewModel].
  const CourseDetailViewModelFamily();

  /// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
  ///
  /// Copied from [courseDetailViewModel].
  CourseDetailViewModelProvider call(
    String courseSlug,
  ) {
    return CourseDetailViewModelProvider(
      courseSlug,
    );
  }

  @override
  CourseDetailViewModelProvider getProviderOverride(
    covariant CourseDetailViewModelProvider provider,
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
  String? get name => r'courseDetailViewModelProvider';
}

/// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
///
/// Copied from [courseDetailViewModel].
class CourseDetailViewModelProvider
    extends AutoDisposeFutureProvider<CourseDetail?> {
  /// 코스 슬러그 기반으로 상세 정보를 조회하는 ViewModel입니다.
  ///
  /// Copied from [courseDetailViewModel].
  CourseDetailViewModelProvider(
    String courseSlug,
  ) : this._internal(
          (ref) => courseDetailViewModel(
            ref as CourseDetailViewModelRef,
            courseSlug,
          ),
          from: courseDetailViewModelProvider,
          name: r'courseDetailViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseDetailViewModelHash,
          dependencies: CourseDetailViewModelFamily._dependencies,
          allTransitiveDependencies:
              CourseDetailViewModelFamily._allTransitiveDependencies,
          courseSlug: courseSlug,
        );

  CourseDetailViewModelProvider._internal(
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
    FutureOr<CourseDetail?> Function(CourseDetailViewModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailViewModelProvider._internal(
        (ref) => create(ref as CourseDetailViewModelRef),
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
  AutoDisposeFutureProviderElement<CourseDetail?> createElement() {
    return _CourseDetailViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailViewModelProvider &&
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
mixin CourseDetailViewModelRef on AutoDisposeFutureProviderRef<CourseDetail?> {
  /// The parameter `courseSlug` of this provider.
  String get courseSlug;
}

class _CourseDetailViewModelProviderElement
    extends AutoDisposeFutureProviderElement<CourseDetail?>
    with CourseDetailViewModelRef {
  _CourseDetailViewModelProviderElement(super.provider);

  @override
  String get courseSlug => (origin as CourseDetailViewModelProvider).courseSlug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
