// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_phase_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coursePhaseViewModelHash() =>
    r'434569d182eb0a38d886d22d845105ae72b8387d';

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

/// 과정별 카드에서 사용할 코스를 조회합니다.
///
/// Copied from [coursePhaseViewModel].
@ProviderFor(coursePhaseViewModel)
const coursePhaseViewModelProvider = CoursePhaseViewModelFamily();

/// 과정별 카드에서 사용할 코스를 조회합니다.
///
/// Copied from [coursePhaseViewModel].
class CoursePhaseViewModelFamily extends Family<AsyncValue<Course?>> {
  /// 과정별 카드에서 사용할 코스를 조회합니다.
  ///
  /// Copied from [coursePhaseViewModel].
  const CoursePhaseViewModelFamily();

  /// 과정별 카드에서 사용할 코스를 조회합니다.
  ///
  /// Copied from [coursePhaseViewModel].
  CoursePhaseViewModelProvider call({
    required String phase,
    String? track,
    String? status,
  }) {
    return CoursePhaseViewModelProvider(
      phase: phase,
      track: track,
      status: status,
    );
  }

  @override
  CoursePhaseViewModelProvider getProviderOverride(
    covariant CoursePhaseViewModelProvider provider,
  ) {
    return call(
      phase: provider.phase,
      track: provider.track,
      status: provider.status,
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
  String? get name => r'coursePhaseViewModelProvider';
}

/// 과정별 카드에서 사용할 코스를 조회합니다.
///
/// Copied from [coursePhaseViewModel].
class CoursePhaseViewModelProvider extends AutoDisposeFutureProvider<Course?> {
  /// 과정별 카드에서 사용할 코스를 조회합니다.
  ///
  /// Copied from [coursePhaseViewModel].
  CoursePhaseViewModelProvider({
    required String phase,
    String? track,
    String? status,
  }) : this._internal(
          (ref) => coursePhaseViewModel(
            ref as CoursePhaseViewModelRef,
            phase: phase,
            track: track,
            status: status,
          ),
          from: coursePhaseViewModelProvider,
          name: r'coursePhaseViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$coursePhaseViewModelHash,
          dependencies: CoursePhaseViewModelFamily._dependencies,
          allTransitiveDependencies:
              CoursePhaseViewModelFamily._allTransitiveDependencies,
          phase: phase,
          track: track,
          status: status,
        );

  CoursePhaseViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phase,
    required this.track,
    required this.status,
  }) : super.internal();

  final String phase;
  final String? track;
  final String? status;

  @override
  Override overrideWith(
    FutureOr<Course?> Function(CoursePhaseViewModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CoursePhaseViewModelProvider._internal(
        (ref) => create(ref as CoursePhaseViewModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phase: phase,
        track: track,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Course?> createElement() {
    return _CoursePhaseViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursePhaseViewModelProvider &&
        other.phase == phase &&
        other.track == track &&
        other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phase.hashCode);
    hash = _SystemHash.combine(hash, track.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoursePhaseViewModelRef on AutoDisposeFutureProviderRef<Course?> {
  /// The parameter `phase` of this provider.
  String get phase;

  /// The parameter `track` of this provider.
  String? get track;

  /// The parameter `status` of this provider.
  String? get status;
}

class _CoursePhaseViewModelProviderElement
    extends AutoDisposeFutureProviderElement<Course?>
    with CoursePhaseViewModelRef {
  _CoursePhaseViewModelProviderElement(super.provider);

  @override
  String get phase => (origin as CoursePhaseViewModelProvider).phase;
  @override
  String? get track => (origin as CoursePhaseViewModelProvider).track;
  @override
  String? get status => (origin as CoursePhaseViewModelProvider).status;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
