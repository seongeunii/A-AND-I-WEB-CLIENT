// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_assignments_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseAssignmentsViewModelHash() =>
    r'25f7cbb92c342bf1d2baa60f94484a1c8ee05da5';

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

/// 코스 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseAssignmentsViewModel].
@ProviderFor(courseAssignmentsViewModel)
const courseAssignmentsViewModelProvider = CourseAssignmentsViewModelFamily();

/// 코스 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseAssignmentsViewModel].
class CourseAssignmentsViewModelFamily
    extends Family<AsyncValue<List<CourseAssignment>>> {
  /// 코스 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseAssignmentsViewModel].
  const CourseAssignmentsViewModelFamily();

  /// 코스 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseAssignmentsViewModel].
  CourseAssignmentsViewModelProvider call(
    CourseAssignmentsQuery query,
  ) {
    return CourseAssignmentsViewModelProvider(
      query,
    );
  }

  @override
  CourseAssignmentsViewModelProvider getProviderOverride(
    covariant CourseAssignmentsViewModelProvider provider,
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
  String? get name => r'courseAssignmentsViewModelProvider';
}

/// 코스 과제 목록 조회 ViewModel입니다.
///
/// Copied from [courseAssignmentsViewModel].
class CourseAssignmentsViewModelProvider
    extends AutoDisposeFutureProvider<List<CourseAssignment>> {
  /// 코스 과제 목록 조회 ViewModel입니다.
  ///
  /// Copied from [courseAssignmentsViewModel].
  CourseAssignmentsViewModelProvider(
    CourseAssignmentsQuery query,
  ) : this._internal(
          (ref) => courseAssignmentsViewModel(
            ref as CourseAssignmentsViewModelRef,
            query,
          ),
          from: courseAssignmentsViewModelProvider,
          name: r'courseAssignmentsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseAssignmentsViewModelHash,
          dependencies: CourseAssignmentsViewModelFamily._dependencies,
          allTransitiveDependencies:
              CourseAssignmentsViewModelFamily._allTransitiveDependencies,
          query: query,
        );

  CourseAssignmentsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final CourseAssignmentsQuery query;

  @override
  Override overrideWith(
    FutureOr<List<CourseAssignment>> Function(
            CourseAssignmentsViewModelRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseAssignmentsViewModelProvider._internal(
        (ref) => create(ref as CourseAssignmentsViewModelRef),
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
    return _CourseAssignmentsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseAssignmentsViewModelProvider && other.query == query;
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
mixin CourseAssignmentsViewModelRef
    on AutoDisposeFutureProviderRef<List<CourseAssignment>> {
  /// The parameter `query` of this provider.
  CourseAssignmentsQuery get query;
}

class _CourseAssignmentsViewModelProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseAssignment>>
    with CourseAssignmentsViewModelRef {
  _CourseAssignmentsViewModelProviderElement(super.provider);

  @override
  CourseAssignmentsQuery get query =>
      (origin as CourseAssignmentsViewModelProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
