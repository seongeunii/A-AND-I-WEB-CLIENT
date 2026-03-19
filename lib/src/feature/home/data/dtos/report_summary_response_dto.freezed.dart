// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_summary_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CourseOutlineResponseDto {
  bool get success;
  CourseOutlineDataDto? get data;
  ErrorData? get error;
  String? get timestamp;

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseOutlineResponseDtoCopyWith<CourseOutlineResponseDto> get copyWith =>
      _$CourseOutlineResponseDtoCopyWithImpl<CourseOutlineResponseDto>(
          this as CourseOutlineResponseDto, _$identity);

  /// Serializes this CourseOutlineResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseOutlineResponseDto &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, error, timestamp);

  @override
  String toString() {
    return 'CourseOutlineResponseDto(success: $success, data: $data, error: $error, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $CourseOutlineResponseDtoCopyWith<$Res> {
  factory $CourseOutlineResponseDtoCopyWith(CourseOutlineResponseDto value,
          $Res Function(CourseOutlineResponseDto) _then) =
      _$CourseOutlineResponseDtoCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      CourseOutlineDataDto? data,
      ErrorData? error,
      String? timestamp});

  $CourseOutlineDataDtoCopyWith<$Res>? get data;
  $ErrorDataCopyWith<$Res>? get error;
}

/// @nodoc
class _$CourseOutlineResponseDtoCopyWithImpl<$Res>
    implements $CourseOutlineResponseDtoCopyWith<$Res> {
  _$CourseOutlineResponseDtoCopyWithImpl(this._self, this._then);

  final CourseOutlineResponseDto _self;
  final $Res Function(CourseOutlineResponseDto) _then;

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? error = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as CourseOutlineDataDto?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorData?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseOutlineDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $CourseOutlineDataDtoCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ErrorDataCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CourseOutlineResponseDto].
extension CourseOutlineResponseDtoPatterns on CourseOutlineResponseDto {
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
    TResult Function(_CourseOutlineResponseDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto() when $default != null:
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
    TResult Function(_CourseOutlineResponseDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto():
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
    TResult? Function(_CourseOutlineResponseDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto() when $default != null:
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
    TResult Function(bool success, CourseOutlineDataDto? data, ErrorData? error,
            String? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto() when $default != null:
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
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
    TResult Function(bool success, CourseOutlineDataDto? data, ErrorData? error,
            String? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto():
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
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
    TResult? Function(bool success, CourseOutlineDataDto? data,
            ErrorData? error, String? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineResponseDto() when $default != null:
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseOutlineResponseDto extends CourseOutlineResponseDto {
  const _CourseOutlineResponseDto(
      {required this.success, this.data, this.error, this.timestamp})
      : super._();
  factory _CourseOutlineResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineResponseDtoFromJson(json);

  @override
  final bool success;
  @override
  final CourseOutlineDataDto? data;
  @override
  final ErrorData? error;
  @override
  final String? timestamp;

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseOutlineResponseDtoCopyWith<_CourseOutlineResponseDto> get copyWith =>
      __$CourseOutlineResponseDtoCopyWithImpl<_CourseOutlineResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseOutlineResponseDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseOutlineResponseDto &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, error, timestamp);

  @override
  String toString() {
    return 'CourseOutlineResponseDto(success: $success, data: $data, error: $error, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$CourseOutlineResponseDtoCopyWith<$Res>
    implements $CourseOutlineResponseDtoCopyWith<$Res> {
  factory _$CourseOutlineResponseDtoCopyWith(_CourseOutlineResponseDto value,
          $Res Function(_CourseOutlineResponseDto) _then) =
      __$CourseOutlineResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success,
      CourseOutlineDataDto? data,
      ErrorData? error,
      String? timestamp});

  @override
  $CourseOutlineDataDtoCopyWith<$Res>? get data;
  @override
  $ErrorDataCopyWith<$Res>? get error;
}

/// @nodoc
class __$CourseOutlineResponseDtoCopyWithImpl<$Res>
    implements _$CourseOutlineResponseDtoCopyWith<$Res> {
  __$CourseOutlineResponseDtoCopyWithImpl(this._self, this._then);

  final _CourseOutlineResponseDto _self;
  final $Res Function(_CourseOutlineResponseDto) _then;

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? data = freezed,
    Object? error = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_CourseOutlineResponseDto(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as CourseOutlineDataDto?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorData?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseOutlineDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
      return null;
    }

    return $CourseOutlineDataDtoCopyWith<$Res>(_self.data!, (value) {
      return _then(_self.copyWith(data: value));
    });
  }

  /// Create a copy of CourseOutlineResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ErrorDataCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// @nodoc
mixin _$CourseOutlineDataDto {
  CourseOutlineHeaderDto get course;
  int get totalAssignments;
  List<CourseOutlineAssignmentDto> get assignments;

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseOutlineDataDtoCopyWith<CourseOutlineDataDto> get copyWith =>
      _$CourseOutlineDataDtoCopyWithImpl<CourseOutlineDataDto>(
          this as CourseOutlineDataDto, _$identity);

  /// Serializes this CourseOutlineDataDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseOutlineDataDto &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.totalAssignments, totalAssignments) ||
                other.totalAssignments == totalAssignments) &&
            const DeepCollectionEquality()
                .equals(other.assignments, assignments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, course, totalAssignments,
      const DeepCollectionEquality().hash(assignments));

  @override
  String toString() {
    return 'CourseOutlineDataDto(course: $course, totalAssignments: $totalAssignments, assignments: $assignments)';
  }
}

/// @nodoc
abstract mixin class $CourseOutlineDataDtoCopyWith<$Res> {
  factory $CourseOutlineDataDtoCopyWith(CourseOutlineDataDto value,
          $Res Function(CourseOutlineDataDto) _then) =
      _$CourseOutlineDataDtoCopyWithImpl;
  @useResult
  $Res call(
      {CourseOutlineHeaderDto course,
      int totalAssignments,
      List<CourseOutlineAssignmentDto> assignments});

  $CourseOutlineHeaderDtoCopyWith<$Res> get course;
}

/// @nodoc
class _$CourseOutlineDataDtoCopyWithImpl<$Res>
    implements $CourseOutlineDataDtoCopyWith<$Res> {
  _$CourseOutlineDataDtoCopyWithImpl(this._self, this._then);

  final CourseOutlineDataDto _self;
  final $Res Function(CourseOutlineDataDto) _then;

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? totalAssignments = null,
    Object? assignments = null,
  }) {
    return _then(_self.copyWith(
      course: null == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseOutlineHeaderDto,
      totalAssignments: null == totalAssignments
          ? _self.totalAssignments
          : totalAssignments // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _self.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<CourseOutlineAssignmentDto>,
    ));
  }

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseOutlineHeaderDtoCopyWith<$Res> get course {
    return $CourseOutlineHeaderDtoCopyWith<$Res>(_self.course, (value) {
      return _then(_self.copyWith(course: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CourseOutlineDataDto].
extension CourseOutlineDataDtoPatterns on CourseOutlineDataDto {
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
    TResult Function(_CourseOutlineDataDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto() when $default != null:
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
    TResult Function(_CourseOutlineDataDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto():
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
    TResult? Function(_CourseOutlineDataDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto() when $default != null:
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
    TResult Function(CourseOutlineHeaderDto course, int totalAssignments,
            List<CourseOutlineAssignmentDto> assignments)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto() when $default != null:
        return $default(
            _that.course, _that.totalAssignments, _that.assignments);
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
    TResult Function(CourseOutlineHeaderDto course, int totalAssignments,
            List<CourseOutlineAssignmentDto> assignments)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto():
        return $default(
            _that.course, _that.totalAssignments, _that.assignments);
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
    TResult? Function(CourseOutlineHeaderDto course, int totalAssignments,
            List<CourseOutlineAssignmentDto> assignments)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineDataDto() when $default != null:
        return $default(
            _that.course, _that.totalAssignments, _that.assignments);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseOutlineDataDto implements CourseOutlineDataDto {
  const _CourseOutlineDataDto(
      {required this.course,
      this.totalAssignments = 0,
      final List<CourseOutlineAssignmentDto> assignments =
          const <CourseOutlineAssignmentDto>[]})
      : _assignments = assignments;
  factory _CourseOutlineDataDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineDataDtoFromJson(json);

  @override
  final CourseOutlineHeaderDto course;
  @override
  @JsonKey()
  final int totalAssignments;
  final List<CourseOutlineAssignmentDto> _assignments;
  @override
  @JsonKey()
  List<CourseOutlineAssignmentDto> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseOutlineDataDtoCopyWith<_CourseOutlineDataDto> get copyWith =>
      __$CourseOutlineDataDtoCopyWithImpl<_CourseOutlineDataDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseOutlineDataDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseOutlineDataDto &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.totalAssignments, totalAssignments) ||
                other.totalAssignments == totalAssignments) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, course, totalAssignments,
      const DeepCollectionEquality().hash(_assignments));

  @override
  String toString() {
    return 'CourseOutlineDataDto(course: $course, totalAssignments: $totalAssignments, assignments: $assignments)';
  }
}

/// @nodoc
abstract mixin class _$CourseOutlineDataDtoCopyWith<$Res>
    implements $CourseOutlineDataDtoCopyWith<$Res> {
  factory _$CourseOutlineDataDtoCopyWith(_CourseOutlineDataDto value,
          $Res Function(_CourseOutlineDataDto) _then) =
      __$CourseOutlineDataDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CourseOutlineHeaderDto course,
      int totalAssignments,
      List<CourseOutlineAssignmentDto> assignments});

  @override
  $CourseOutlineHeaderDtoCopyWith<$Res> get course;
}

/// @nodoc
class __$CourseOutlineDataDtoCopyWithImpl<$Res>
    implements _$CourseOutlineDataDtoCopyWith<$Res> {
  __$CourseOutlineDataDtoCopyWithImpl(this._self, this._then);

  final _CourseOutlineDataDto _self;
  final $Res Function(_CourseOutlineDataDto) _then;

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? course = null,
    Object? totalAssignments = null,
    Object? assignments = null,
  }) {
    return _then(_CourseOutlineDataDto(
      course: null == course
          ? _self.course
          : course // ignore: cast_nullable_to_non_nullable
              as CourseOutlineHeaderDto,
      totalAssignments: null == totalAssignments
          ? _self.totalAssignments
          : totalAssignments // ignore: cast_nullable_to_non_nullable
              as int,
      assignments: null == assignments
          ? _self._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<CourseOutlineAssignmentDto>,
    ));
  }

  /// Create a copy of CourseOutlineDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseOutlineHeaderDtoCopyWith<$Res> get course {
    return $CourseOutlineHeaderDtoCopyWith<$Res>(_self.course, (value) {
      return _then(_self.copyWith(course: value));
    });
  }
}

/// @nodoc
mixin _$CourseOutlineHeaderDto {
  String get id;
  String get slug;
  String get fieldTag;
  String get title;
  String get description;
  String get phase;

  /// Create a copy of CourseOutlineHeaderDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseOutlineHeaderDtoCopyWith<CourseOutlineHeaderDto> get copyWith =>
      _$CourseOutlineHeaderDtoCopyWithImpl<CourseOutlineHeaderDto>(
          this as CourseOutlineHeaderDto, _$identity);

  /// Serializes this CourseOutlineHeaderDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseOutlineHeaderDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.fieldTag, fieldTag) ||
                other.fieldTag == fieldTag) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, slug, fieldTag, title, description, phase);

  @override
  String toString() {
    return 'CourseOutlineHeaderDto(id: $id, slug: $slug, fieldTag: $fieldTag, title: $title, description: $description, phase: $phase)';
  }
}

/// @nodoc
abstract mixin class $CourseOutlineHeaderDtoCopyWith<$Res> {
  factory $CourseOutlineHeaderDtoCopyWith(CourseOutlineHeaderDto value,
          $Res Function(CourseOutlineHeaderDto) _then) =
      _$CourseOutlineHeaderDtoCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String slug,
      String fieldTag,
      String title,
      String description,
      String phase});
}

/// @nodoc
class _$CourseOutlineHeaderDtoCopyWithImpl<$Res>
    implements $CourseOutlineHeaderDtoCopyWith<$Res> {
  _$CourseOutlineHeaderDtoCopyWithImpl(this._self, this._then);

  final CourseOutlineHeaderDto _self;
  final $Res Function(CourseOutlineHeaderDto) _then;

  /// Create a copy of CourseOutlineHeaderDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? fieldTag = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      fieldTag: null == fieldTag
          ? _self.fieldTag
          : fieldTag // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CourseOutlineHeaderDto].
extension CourseOutlineHeaderDtoPatterns on CourseOutlineHeaderDto {
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
    TResult Function(_CourseOutlineHeaderDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto() when $default != null:
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
    TResult Function(_CourseOutlineHeaderDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto():
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
    TResult? Function(_CourseOutlineHeaderDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto() when $default != null:
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
    TResult Function(String id, String slug, String fieldTag, String title,
            String description, String phase)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto() when $default != null:
        return $default(_that.id, _that.slug, _that.fieldTag, _that.title,
            _that.description, _that.phase);
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
    TResult Function(String id, String slug, String fieldTag, String title,
            String description, String phase)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto():
        return $default(_that.id, _that.slug, _that.fieldTag, _that.title,
            _that.description, _that.phase);
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
    TResult? Function(String id, String slug, String fieldTag, String title,
            String description, String phase)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineHeaderDto() when $default != null:
        return $default(_that.id, _that.slug, _that.fieldTag, _that.title,
            _that.description, _that.phase);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseOutlineHeaderDto implements CourseOutlineHeaderDto {
  const _CourseOutlineHeaderDto(
      {required this.id,
      required this.slug,
      required this.fieldTag,
      required this.title,
      required this.description,
      required this.phase});
  factory _CourseOutlineHeaderDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineHeaderDtoFromJson(json);

  @override
  final String id;
  @override
  final String slug;
  @override
  final String fieldTag;
  @override
  final String title;
  @override
  final String description;
  @override
  final String phase;

  /// Create a copy of CourseOutlineHeaderDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseOutlineHeaderDtoCopyWith<_CourseOutlineHeaderDto> get copyWith =>
      __$CourseOutlineHeaderDtoCopyWithImpl<_CourseOutlineHeaderDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseOutlineHeaderDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseOutlineHeaderDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.fieldTag, fieldTag) ||
                other.fieldTag == fieldTag) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, slug, fieldTag, title, description, phase);

  @override
  String toString() {
    return 'CourseOutlineHeaderDto(id: $id, slug: $slug, fieldTag: $fieldTag, title: $title, description: $description, phase: $phase)';
  }
}

/// @nodoc
abstract mixin class _$CourseOutlineHeaderDtoCopyWith<$Res>
    implements $CourseOutlineHeaderDtoCopyWith<$Res> {
  factory _$CourseOutlineHeaderDtoCopyWith(_CourseOutlineHeaderDto value,
          $Res Function(_CourseOutlineHeaderDto) _then) =
      __$CourseOutlineHeaderDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String slug,
      String fieldTag,
      String title,
      String description,
      String phase});
}

/// @nodoc
class __$CourseOutlineHeaderDtoCopyWithImpl<$Res>
    implements _$CourseOutlineHeaderDtoCopyWith<$Res> {
  __$CourseOutlineHeaderDtoCopyWithImpl(this._self, this._then);

  final _CourseOutlineHeaderDto _self;
  final $Res Function(_CourseOutlineHeaderDto) _then;

  /// Create a copy of CourseOutlineHeaderDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? slug = null,
    Object? fieldTag = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
  }) {
    return _then(_CourseOutlineHeaderDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      fieldTag: null == fieldTag
          ? _self.fieldTag
          : fieldTag // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      phase: null == phase
          ? _self.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CourseOutlineAssignmentDto {
  String get assignmentId;
  int get weekNo;
  int get orderInWeek;
  String get title;
  String get difficulty;
  DateTime get startAt;
  DateTime get endAt;
  bool get checked;

  /// Create a copy of CourseOutlineAssignmentDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CourseOutlineAssignmentDtoCopyWith<CourseOutlineAssignmentDto>
      get copyWith =>
          _$CourseOutlineAssignmentDtoCopyWithImpl<CourseOutlineAssignmentDto>(
              this as CourseOutlineAssignmentDto, _$identity);

  /// Serializes this CourseOutlineAssignmentDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CourseOutlineAssignmentDto &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.weekNo, weekNo) || other.weekNo == weekNo) &&
            (identical(other.orderInWeek, orderInWeek) ||
                other.orderInWeek == orderInWeek) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.checked, checked) || other.checked == checked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, assignmentId, weekNo,
      orderInWeek, title, difficulty, startAt, endAt, checked);

  @override
  String toString() {
    return 'CourseOutlineAssignmentDto(assignmentId: $assignmentId, weekNo: $weekNo, orderInWeek: $orderInWeek, title: $title, difficulty: $difficulty, startAt: $startAt, endAt: $endAt, checked: $checked)';
  }
}

/// @nodoc
abstract mixin class $CourseOutlineAssignmentDtoCopyWith<$Res> {
  factory $CourseOutlineAssignmentDtoCopyWith(CourseOutlineAssignmentDto value,
          $Res Function(CourseOutlineAssignmentDto) _then) =
      _$CourseOutlineAssignmentDtoCopyWithImpl;
  @useResult
  $Res call(
      {String assignmentId,
      int weekNo,
      int orderInWeek,
      String title,
      String difficulty,
      DateTime startAt,
      DateTime endAt,
      bool checked});
}

/// @nodoc
class _$CourseOutlineAssignmentDtoCopyWithImpl<$Res>
    implements $CourseOutlineAssignmentDtoCopyWith<$Res> {
  _$CourseOutlineAssignmentDtoCopyWithImpl(this._self, this._then);

  final CourseOutlineAssignmentDto _self;
  final $Res Function(CourseOutlineAssignmentDto) _then;

  /// Create a copy of CourseOutlineAssignmentDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignmentId = null,
    Object? weekNo = null,
    Object? orderInWeek = null,
    Object? title = null,
    Object? difficulty = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? checked = null,
  }) {
    return _then(_self.copyWith(
      assignmentId: null == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      weekNo: null == weekNo
          ? _self.weekNo
          : weekNo // ignore: cast_nullable_to_non_nullable
              as int,
      orderInWeek: null == orderInWeek
          ? _self.orderInWeek
          : orderInWeek // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _self.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _self.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checked: null == checked
          ? _self.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [CourseOutlineAssignmentDto].
extension CourseOutlineAssignmentDtoPatterns on CourseOutlineAssignmentDto {
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
    TResult Function(_CourseOutlineAssignmentDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto() when $default != null:
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
    TResult Function(_CourseOutlineAssignmentDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto():
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
    TResult? Function(_CourseOutlineAssignmentDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto() when $default != null:
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
            String assignmentId,
            int weekNo,
            int orderInWeek,
            String title,
            String difficulty,
            DateTime startAt,
            DateTime endAt,
            bool checked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto() when $default != null:
        return $default(
            _that.assignmentId,
            _that.weekNo,
            _that.orderInWeek,
            _that.title,
            _that.difficulty,
            _that.startAt,
            _that.endAt,
            _that.checked);
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
            String assignmentId,
            int weekNo,
            int orderInWeek,
            String title,
            String difficulty,
            DateTime startAt,
            DateTime endAt,
            bool checked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto():
        return $default(
            _that.assignmentId,
            _that.weekNo,
            _that.orderInWeek,
            _that.title,
            _that.difficulty,
            _that.startAt,
            _that.endAt,
            _that.checked);
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
            String assignmentId,
            int weekNo,
            int orderInWeek,
            String title,
            String difficulty,
            DateTime startAt,
            DateTime endAt,
            bool checked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CourseOutlineAssignmentDto() when $default != null:
        return $default(
            _that.assignmentId,
            _that.weekNo,
            _that.orderInWeek,
            _that.title,
            _that.difficulty,
            _that.startAt,
            _that.endAt,
            _that.checked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CourseOutlineAssignmentDto extends CourseOutlineAssignmentDto {
  const _CourseOutlineAssignmentDto(
      {required this.assignmentId,
      required this.weekNo,
      required this.orderInWeek,
      required this.title,
      required this.difficulty,
      required this.startAt,
      required this.endAt,
      this.checked = false})
      : super._();
  factory _CourseOutlineAssignmentDto.fromJson(Map<String, dynamic> json) =>
      _$CourseOutlineAssignmentDtoFromJson(json);

  @override
  final String assignmentId;
  @override
  final int weekNo;
  @override
  final int orderInWeek;
  @override
  final String title;
  @override
  final String difficulty;
  @override
  final DateTime startAt;
  @override
  final DateTime endAt;
  @override
  @JsonKey()
  final bool checked;

  /// Create a copy of CourseOutlineAssignmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CourseOutlineAssignmentDtoCopyWith<_CourseOutlineAssignmentDto>
      get copyWith => __$CourseOutlineAssignmentDtoCopyWithImpl<
          _CourseOutlineAssignmentDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CourseOutlineAssignmentDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CourseOutlineAssignmentDto &&
            (identical(other.assignmentId, assignmentId) ||
                other.assignmentId == assignmentId) &&
            (identical(other.weekNo, weekNo) || other.weekNo == weekNo) &&
            (identical(other.orderInWeek, orderInWeek) ||
                other.orderInWeek == orderInWeek) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt) &&
            (identical(other.checked, checked) || other.checked == checked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, assignmentId, weekNo,
      orderInWeek, title, difficulty, startAt, endAt, checked);

  @override
  String toString() {
    return 'CourseOutlineAssignmentDto(assignmentId: $assignmentId, weekNo: $weekNo, orderInWeek: $orderInWeek, title: $title, difficulty: $difficulty, startAt: $startAt, endAt: $endAt, checked: $checked)';
  }
}

/// @nodoc
abstract mixin class _$CourseOutlineAssignmentDtoCopyWith<$Res>
    implements $CourseOutlineAssignmentDtoCopyWith<$Res> {
  factory _$CourseOutlineAssignmentDtoCopyWith(
          _CourseOutlineAssignmentDto value,
          $Res Function(_CourseOutlineAssignmentDto) _then) =
      __$CourseOutlineAssignmentDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String assignmentId,
      int weekNo,
      int orderInWeek,
      String title,
      String difficulty,
      DateTime startAt,
      DateTime endAt,
      bool checked});
}

/// @nodoc
class __$CourseOutlineAssignmentDtoCopyWithImpl<$Res>
    implements _$CourseOutlineAssignmentDtoCopyWith<$Res> {
  __$CourseOutlineAssignmentDtoCopyWithImpl(this._self, this._then);

  final _CourseOutlineAssignmentDto _self;
  final $Res Function(_CourseOutlineAssignmentDto) _then;

  /// Create a copy of CourseOutlineAssignmentDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assignmentId = null,
    Object? weekNo = null,
    Object? orderInWeek = null,
    Object? title = null,
    Object? difficulty = null,
    Object? startAt = null,
    Object? endAt = null,
    Object? checked = null,
  }) {
    return _then(_CourseOutlineAssignmentDto(
      assignmentId: null == assignmentId
          ? _self.assignmentId
          : assignmentId // ignore: cast_nullable_to_non_nullable
              as String,
      weekNo: null == weekNo
          ? _self.weekNo
          : weekNo // ignore: cast_nullable_to_non_nullable
              as int,
      orderInWeek: null == orderInWeek
          ? _self.orderInWeek
          : orderInWeek // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _self.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _self.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endAt: null == endAt
          ? _self.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      checked: null == checked
          ? _self.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ReportSummaryResponseDto {
  bool get success;
  List<ReportSummary> get data;
  ErrorData? get error;
  String? get timestamp;

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReportSummaryResponseDtoCopyWith<ReportSummaryResponseDto> get copyWith =>
      _$ReportSummaryResponseDtoCopyWithImpl<ReportSummaryResponseDto>(
          this as ReportSummaryResponseDto, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReportSummaryResponseDto &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success,
      const DeepCollectionEquality().hash(data), error, timestamp);

  @override
  String toString() {
    return 'ReportSummaryResponseDto(success: $success, data: $data, error: $error, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $ReportSummaryResponseDtoCopyWith<$Res> {
  factory $ReportSummaryResponseDtoCopyWith(ReportSummaryResponseDto value,
          $Res Function(ReportSummaryResponseDto) _then) =
      _$ReportSummaryResponseDtoCopyWithImpl;
  @useResult
  $Res call(
      {bool success,
      List<ReportSummary> data,
      ErrorData? error,
      String? timestamp});

  $ErrorDataCopyWith<$Res>? get error;
}

/// @nodoc
class _$ReportSummaryResponseDtoCopyWithImpl<$Res>
    implements $ReportSummaryResponseDtoCopyWith<$Res> {
  _$ReportSummaryResponseDtoCopyWithImpl(this._self, this._then);

  final ReportSummaryResponseDto _self;
  final $Res Function(ReportSummaryResponseDto) _then;

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? error = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportSummary>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorData?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ErrorDataCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ReportSummaryResponseDto].
extension ReportSummaryResponseDtoPatterns on ReportSummaryResponseDto {
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
    TResult Function(_ReportSummaryResponseDto value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto() when $default != null:
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
    TResult Function(_ReportSummaryResponseDto value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto():
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
    TResult? Function(_ReportSummaryResponseDto value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto() when $default != null:
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
    TResult Function(bool success, List<ReportSummary> data, ErrorData? error,
            String? timestamp)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto() when $default != null:
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
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
    TResult Function(bool success, List<ReportSummary> data, ErrorData? error,
            String? timestamp)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto():
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
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
    TResult? Function(bool success, List<ReportSummary> data, ErrorData? error,
            String? timestamp)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSummaryResponseDto() when $default != null:
        return $default(
            _that.success, _that.data, _that.error, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReportSummaryResponseDto extends ReportSummaryResponseDto {
  const _ReportSummaryResponseDto(
      {required this.success,
      required final List<ReportSummary> data,
      this.error,
      this.timestamp})
      : _data = data,
        super._();

  @override
  final bool success;
  final List<ReportSummary> _data;
  @override
  List<ReportSummary> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final ErrorData? error;
  @override
  final String? timestamp;

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReportSummaryResponseDtoCopyWith<_ReportSummaryResponseDto> get copyWith =>
      __$ReportSummaryResponseDtoCopyWithImpl<_ReportSummaryResponseDto>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReportSummaryResponseDto &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, success,
      const DeepCollectionEquality().hash(_data), error, timestamp);

  @override
  String toString() {
    return 'ReportSummaryResponseDto(success: $success, data: $data, error: $error, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$ReportSummaryResponseDtoCopyWith<$Res>
    implements $ReportSummaryResponseDtoCopyWith<$Res> {
  factory _$ReportSummaryResponseDtoCopyWith(_ReportSummaryResponseDto value,
          $Res Function(_ReportSummaryResponseDto) _then) =
      __$ReportSummaryResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool success,
      List<ReportSummary> data,
      ErrorData? error,
      String? timestamp});

  @override
  $ErrorDataCopyWith<$Res>? get error;
}

/// @nodoc
class __$ReportSummaryResponseDtoCopyWithImpl<$Res>
    implements _$ReportSummaryResponseDtoCopyWith<$Res> {
  __$ReportSummaryResponseDtoCopyWithImpl(this._self, this._then);

  final _ReportSummaryResponseDto _self;
  final $Res Function(_ReportSummaryResponseDto) _then;

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? error = freezed,
    Object? timestamp = freezed,
  }) {
    return _then(_ReportSummaryResponseDto(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ReportSummary>,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorData?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of ReportSummaryResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
      return null;
    }

    return $ErrorDataCopyWith<$Res>(_self.error!, (value) {
      return _then(_self.copyWith(error: value));
    });
  }
}

/// @nodoc
mixin _$ErrorData {
  String get code;
  String get message;

  /// Create a copy of ErrorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorDataCopyWith<ErrorData> get copyWith =>
      _$ErrorDataCopyWithImpl<ErrorData>(this as ErrorData, _$identity);

  /// Serializes this ErrorData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorData &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @override
  String toString() {
    return 'ErrorData(code: $code, message: $message)';
  }
}

/// @nodoc
abstract mixin class $ErrorDataCopyWith<$Res> {
  factory $ErrorDataCopyWith(ErrorData value, $Res Function(ErrorData) _then) =
      _$ErrorDataCopyWithImpl;
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class _$ErrorDataCopyWithImpl<$Res> implements $ErrorDataCopyWith<$Res> {
  _$ErrorDataCopyWithImpl(this._self, this._then);

  final ErrorData _self;
  final $Res Function(ErrorData) _then;

  /// Create a copy of ErrorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ErrorData].
extension ErrorDataPatterns on ErrorData {
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
    TResult Function(_ErrorData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ErrorData() when $default != null:
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
    TResult Function(_ErrorData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ErrorData():
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
    TResult? Function(_ErrorData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ErrorData() when $default != null:
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
    TResult Function(String code, String message)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ErrorData() when $default != null:
        return $default(_that.code, _that.message);
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
    TResult Function(String code, String message) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ErrorData():
        return $default(_that.code, _that.message);
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
    TResult? Function(String code, String message)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ErrorData() when $default != null:
        return $default(_that.code, _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ErrorData implements ErrorData {
  const _ErrorData({required this.code, required this.message});
  factory _ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);

  @override
  final String code;
  @override
  final String message;

  /// Create a copy of ErrorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ErrorDataCopyWith<_ErrorData> get copyWith =>
      __$ErrorDataCopyWithImpl<_ErrorData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ErrorDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorData &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @override
  String toString() {
    return 'ErrorData(code: $code, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ErrorDataCopyWith<$Res>
    implements $ErrorDataCopyWith<$Res> {
  factory _$ErrorDataCopyWith(
          _ErrorData value, $Res Function(_ErrorData) _then) =
      __$ErrorDataCopyWithImpl;
  @override
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class __$ErrorDataCopyWithImpl<$Res> implements _$ErrorDataCopyWith<$Res> {
  __$ErrorDataCopyWithImpl(this._self, this._then);

  final _ErrorData _self;
  final $Res Function(_ErrorData) _then;

  /// Create a copy of ErrorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_ErrorData(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
