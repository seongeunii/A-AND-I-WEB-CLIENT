// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submission_result_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubmissionResultResponseDto {
  String get submissionId;
  String? get problemId;
  String? get language;
  String get status;
  @JsonKey(fromJson: _parseTestCases)
  List<SubmissionTestCaseResult> get testCases;
  DateTime? get createdAt;
  DateTime? get completedAt;

  /// Create a copy of SubmissionResultResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubmissionResultResponseDtoCopyWith<SubmissionResultResponseDto>
      get copyWith => _$SubmissionResultResponseDtoCopyWithImpl<
              SubmissionResultResponseDto>(
          this as SubmissionResultResponseDto, _$identity);

  /// Serializes this SubmissionResultResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubmissionResultResponseDto &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.problemId, problemId) ||
                other.problemId == problemId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.testCases, testCases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      submissionId,
      problemId,
      language,
      status,
      const DeepCollectionEquality().hash(testCases),
      createdAt,
      completedAt);

  @override
  String toString() {
    return 'SubmissionResultResponseDto(submissionId: $submissionId, problemId: $problemId, language: $language, status: $status, testCases: $testCases, createdAt: $createdAt, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $SubmissionResultResponseDtoCopyWith<$Res> {
  factory $SubmissionResultResponseDtoCopyWith(
          SubmissionResultResponseDto value,
          $Res Function(SubmissionResultResponseDto) _then) =
      _$SubmissionResultResponseDtoCopyWithImpl;
  @useResult
  $Res call(
      {String submissionId,
      String? problemId,
      String? language,
      String status,
      @JsonKey(fromJson: _parseTestCases)
      List<SubmissionTestCaseResult> testCases,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$SubmissionResultResponseDtoCopyWithImpl<$Res>
    implements $SubmissionResultResponseDtoCopyWith<$Res> {
  _$SubmissionResultResponseDtoCopyWithImpl(this._self, this._then);

  final SubmissionResultResponseDto _self;
  final $Res Function(SubmissionResultResponseDto) _then;

  /// Create a copy of SubmissionResultResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submissionId = null,
    Object? problemId = freezed,
    Object? language = freezed,
    Object? status = null,
    Object? testCases = null,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      submissionId: null == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String,
      problemId: freezed == problemId
          ? _self.problemId
          : problemId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _self.testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<SubmissionTestCaseResult>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubmissionResultResponseDto].
extension SubmissionResultResponseDtoPatterns on SubmissionResultResponseDto {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SubmissionResultResponseDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SubmissionResultResponseDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SubmissionResultResponseDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String submissionId,
            String? problemId,
            String? language,
            String status,
            @JsonKey(fromJson: _parseTestCases)
            List<SubmissionTestCaseResult> testCases,
            DateTime? createdAt,
            DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto() when $default != null:
        return $default(_that.submissionId, _that.problemId, _that.language,
            _that.status, _that.testCases, _that.createdAt, _that.completedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String submissionId,
            String? problemId,
            String? language,
            String status,
            @JsonKey(fromJson: _parseTestCases)
            List<SubmissionTestCaseResult> testCases,
            DateTime? createdAt,
            DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto():
        return $default(_that.submissionId, _that.problemId, _that.language,
            _that.status, _that.testCases, _that.createdAt, _that.completedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String submissionId,
            String? problemId,
            String? language,
            String status,
            @JsonKey(fromJson: _parseTestCases)
            List<SubmissionTestCaseResult> testCases,
            DateTime? createdAt,
            DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubmissionResultResponseDto() when $default != null:
        return $default(_that.submissionId, _that.problemId, _that.language,
            _that.status, _that.testCases, _that.createdAt, _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubmissionResultResponseDto extends SubmissionResultResponseDto {
  const _SubmissionResultResponseDto(
      {required this.submissionId,
      this.problemId,
      this.language,
      required this.status,
      @JsonKey(fromJson: _parseTestCases)
      final List<SubmissionTestCaseResult> testCases =
          const <SubmissionTestCaseResult>[],
      this.createdAt,
      this.completedAt})
      : _testCases = testCases,
        super._();
  factory _SubmissionResultResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SubmissionResultResponseDtoFromJson(json);

  @override
  final String submissionId;
  @override
  final String? problemId;
  @override
  final String? language;
  @override
  final String status;
  final List<SubmissionTestCaseResult> _testCases;
  @override
  @JsonKey(fromJson: _parseTestCases)
  List<SubmissionTestCaseResult> get testCases {
    if (_testCases is EqualUnmodifiableListView) return _testCases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testCases);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  /// Create a copy of SubmissionResultResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubmissionResultResponseDtoCopyWith<_SubmissionResultResponseDto>
      get copyWith => __$SubmissionResultResponseDtoCopyWithImpl<
          _SubmissionResultResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubmissionResultResponseDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubmissionResultResponseDto &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.problemId, problemId) ||
                other.problemId == problemId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._testCases, _testCases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      submissionId,
      problemId,
      language,
      status,
      const DeepCollectionEquality().hash(_testCases),
      createdAt,
      completedAt);

  @override
  String toString() {
    return 'SubmissionResultResponseDto(submissionId: $submissionId, problemId: $problemId, language: $language, status: $status, testCases: $testCases, createdAt: $createdAt, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$SubmissionResultResponseDtoCopyWith<$Res>
    implements $SubmissionResultResponseDtoCopyWith<$Res> {
  factory _$SubmissionResultResponseDtoCopyWith(
          _SubmissionResultResponseDto value,
          $Res Function(_SubmissionResultResponseDto) _then) =
      __$SubmissionResultResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String submissionId,
      String? problemId,
      String? language,
      String status,
      @JsonKey(fromJson: _parseTestCases)
      List<SubmissionTestCaseResult> testCases,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$SubmissionResultResponseDtoCopyWithImpl<$Res>
    implements _$SubmissionResultResponseDtoCopyWith<$Res> {
  __$SubmissionResultResponseDtoCopyWithImpl(this._self, this._then);

  final _SubmissionResultResponseDto _self;
  final $Res Function(_SubmissionResultResponseDto) _then;

  /// Create a copy of SubmissionResultResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? submissionId = null,
    Object? problemId = freezed,
    Object? language = freezed,
    Object? status = null,
    Object? testCases = null,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_SubmissionResultResponseDto(
      submissionId: null == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String,
      problemId: freezed == problemId
          ? _self.problemId
          : problemId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      testCases: null == testCases
          ? _self._testCases
          : testCases // ignore: cast_nullable_to_non_nullable
              as List<SubmissionTestCaseResult>,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
