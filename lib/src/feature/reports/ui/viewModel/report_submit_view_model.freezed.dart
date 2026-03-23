// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_submit_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportSubmitState {
  SubmitLanguage get selectedLanguage;
  Map<SubmitLanguage, String> get draftCodeByLanguage;
  SubmissionStatus get submissionStatus;
  String get latestSubmittedCode;
  SubmitLanguage? get latestSubmittedLanguage;
  DateTime? get submittedAt;
  int get submitCount;
  int get score;
  List<String> get feedbacks;
  List<SubmissionTestCaseResult> get testCaseResults;
  List<SubmissionResult> get previousSubmissions;
  String? get submissionId;
  String? get streamUrl;
  String? get historyProblemId;
  String? get latestVerdict;
  bool get isSubmitting;
  bool get isPolling;
  bool get isHistoryLoading;
  bool get hasLoadedHistory;
  String get errorMsg;
  String get historyErrorMsg;

  /// Create a copy of ReportSubmitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReportSubmitStateCopyWith<ReportSubmitState> get copyWith =>
      _$ReportSubmitStateCopyWithImpl<ReportSubmitState>(
          this as ReportSubmitState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReportSubmitState &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            const DeepCollectionEquality()
                .equals(other.draftCodeByLanguage, draftCodeByLanguage) &&
            (identical(other.submissionStatus, submissionStatus) ||
                other.submissionStatus == submissionStatus) &&
            (identical(other.latestSubmittedCode, latestSubmittedCode) ||
                other.latestSubmittedCode == latestSubmittedCode) &&
            (identical(
                    other.latestSubmittedLanguage, latestSubmittedLanguage) ||
                other.latestSubmittedLanguage == latestSubmittedLanguage) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.submitCount, submitCount) ||
                other.submitCount == submitCount) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other.feedbacks, feedbacks) &&
            const DeepCollectionEquality()
                .equals(other.testCaseResults, testCaseResults) &&
            const DeepCollectionEquality()
                .equals(other.previousSubmissions, previousSubmissions) &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.historyProblemId, historyProblemId) ||
                other.historyProblemId == historyProblemId) &&
            (identical(other.latestVerdict, latestVerdict) ||
                other.latestVerdict == latestVerdict) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isPolling, isPolling) ||
                other.isPolling == isPolling) &&
            (identical(other.isHistoryLoading, isHistoryLoading) ||
                other.isHistoryLoading == isHistoryLoading) &&
            (identical(other.hasLoadedHistory, hasLoadedHistory) ||
                other.hasLoadedHistory == hasLoadedHistory) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.historyErrorMsg, historyErrorMsg) ||
                other.historyErrorMsg == historyErrorMsg));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        selectedLanguage,
        const DeepCollectionEquality().hash(draftCodeByLanguage),
        submissionStatus,
        latestSubmittedCode,
        latestSubmittedLanguage,
        submittedAt,
        submitCount,
        score,
        const DeepCollectionEquality().hash(feedbacks),
        const DeepCollectionEquality().hash(testCaseResults),
        const DeepCollectionEquality().hash(previousSubmissions),
        submissionId,
        streamUrl,
        historyProblemId,
        latestVerdict,
        isSubmitting,
        isPolling,
        isHistoryLoading,
        hasLoadedHistory,
        errorMsg,
        historyErrorMsg
      ]);

  @override
  String toString() {
    return 'ReportSubmitState(selectedLanguage: $selectedLanguage, draftCodeByLanguage: $draftCodeByLanguage, submissionStatus: $submissionStatus, latestSubmittedCode: $latestSubmittedCode, latestSubmittedLanguage: $latestSubmittedLanguage, submittedAt: $submittedAt, submitCount: $submitCount, score: $score, feedbacks: $feedbacks, testCaseResults: $testCaseResults, previousSubmissions: $previousSubmissions, submissionId: $submissionId, streamUrl: $streamUrl, historyProblemId: $historyProblemId, latestVerdict: $latestVerdict, isSubmitting: $isSubmitting, isPolling: $isPolling, isHistoryLoading: $isHistoryLoading, hasLoadedHistory: $hasLoadedHistory, errorMsg: $errorMsg, historyErrorMsg: $historyErrorMsg)';
  }
}

/// @nodoc
abstract mixin class $ReportSubmitStateCopyWith<$Res> {
  factory $ReportSubmitStateCopyWith(
          ReportSubmitState value, $Res Function(ReportSubmitState) _then) =
      _$ReportSubmitStateCopyWithImpl;
  @useResult
  $Res call(
      {SubmitLanguage selectedLanguage,
      Map<SubmitLanguage, String> draftCodeByLanguage,
      SubmissionStatus submissionStatus,
      String latestSubmittedCode,
      SubmitLanguage? latestSubmittedLanguage,
      DateTime? submittedAt,
      int submitCount,
      int score,
      List<String> feedbacks,
      List<SubmissionTestCaseResult> testCaseResults,
      List<SubmissionResult> previousSubmissions,
      String? submissionId,
      String? streamUrl,
      String? historyProblemId,
      String? latestVerdict,
      bool isSubmitting,
      bool isPolling,
      bool isHistoryLoading,
      bool hasLoadedHistory,
      String errorMsg,
      String historyErrorMsg});
}

/// @nodoc
class _$ReportSubmitStateCopyWithImpl<$Res>
    implements $ReportSubmitStateCopyWith<$Res> {
  _$ReportSubmitStateCopyWithImpl(this._self, this._then);

  final ReportSubmitState _self;
  final $Res Function(ReportSubmitState) _then;

  /// Create a copy of ReportSubmitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLanguage = null,
    Object? draftCodeByLanguage = null,
    Object? submissionStatus = null,
    Object? latestSubmittedCode = null,
    Object? latestSubmittedLanguage = freezed,
    Object? submittedAt = freezed,
    Object? submitCount = null,
    Object? score = null,
    Object? feedbacks = null,
    Object? testCaseResults = null,
    Object? previousSubmissions = null,
    Object? submissionId = freezed,
    Object? streamUrl = freezed,
    Object? historyProblemId = freezed,
    Object? latestVerdict = freezed,
    Object? isSubmitting = null,
    Object? isPolling = null,
    Object? isHistoryLoading = null,
    Object? hasLoadedHistory = null,
    Object? errorMsg = null,
    Object? historyErrorMsg = null,
  }) {
    return _then(_self.copyWith(
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as SubmitLanguage,
      draftCodeByLanguage: null == draftCodeByLanguage
          ? _self.draftCodeByLanguage
          : draftCodeByLanguage // ignore: cast_nullable_to_non_nullable
              as Map<SubmitLanguage, String>,
      submissionStatus: null == submissionStatus
          ? _self.submissionStatus
          : submissionStatus // ignore: cast_nullable_to_non_nullable
              as SubmissionStatus,
      latestSubmittedCode: null == latestSubmittedCode
          ? _self.latestSubmittedCode
          : latestSubmittedCode // ignore: cast_nullable_to_non_nullable
              as String,
      latestSubmittedLanguage: freezed == latestSubmittedLanguage
          ? _self.latestSubmittedLanguage
          : latestSubmittedLanguage // ignore: cast_nullable_to_non_nullable
              as SubmitLanguage?,
      submittedAt: freezed == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      submitCount: null == submitCount
          ? _self.submitCount
          : submitCount // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      feedbacks: null == feedbacks
          ? _self.feedbacks
          : feedbacks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testCaseResults: null == testCaseResults
          ? _self.testCaseResults
          : testCaseResults // ignore: cast_nullable_to_non_nullable
              as List<SubmissionTestCaseResult>,
      previousSubmissions: null == previousSubmissions
          ? _self.previousSubmissions
          : previousSubmissions // ignore: cast_nullable_to_non_nullable
              as List<SubmissionResult>,
      submissionId: freezed == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      streamUrl: freezed == streamUrl
          ? _self.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      historyProblemId: freezed == historyProblemId
          ? _self.historyProblemId
          : historyProblemId // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVerdict: freezed == latestVerdict
          ? _self.latestVerdict
          : latestVerdict // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isPolling: null == isPolling
          ? _self.isPolling
          : isPolling // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _self.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoadedHistory: null == hasLoadedHistory
          ? _self.hasLoadedHistory
          : hasLoadedHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _self.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      historyErrorMsg: null == historyErrorMsg
          ? _self.historyErrorMsg
          : historyErrorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReportSubmitState].
extension ReportSubmitStatePatterns on ReportSubmitState {
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
    TResult Function(_ReportSubmitState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState() when $default != null:
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
    TResult Function(_ReportSubmitState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState():
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
    TResult? Function(_ReportSubmitState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState() when $default != null:
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
            SubmitLanguage selectedLanguage,
            Map<SubmitLanguage, String> draftCodeByLanguage,
            SubmissionStatus submissionStatus,
            String latestSubmittedCode,
            SubmitLanguage? latestSubmittedLanguage,
            DateTime? submittedAt,
            int submitCount,
            int score,
            List<String> feedbacks,
            List<SubmissionTestCaseResult> testCaseResults,
            List<SubmissionResult> previousSubmissions,
            String? submissionId,
            String? streamUrl,
            String? historyProblemId,
            String? latestVerdict,
            bool isSubmitting,
            bool isPolling,
            bool isHistoryLoading,
            bool hasLoadedHistory,
            String errorMsg,
            String historyErrorMsg)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState() when $default != null:
        return $default(
            _that.selectedLanguage,
            _that.draftCodeByLanguage,
            _that.submissionStatus,
            _that.latestSubmittedCode,
            _that.latestSubmittedLanguage,
            _that.submittedAt,
            _that.submitCount,
            _that.score,
            _that.feedbacks,
            _that.testCaseResults,
            _that.previousSubmissions,
            _that.submissionId,
            _that.streamUrl,
            _that.historyProblemId,
            _that.latestVerdict,
            _that.isSubmitting,
            _that.isPolling,
            _that.isHistoryLoading,
            _that.hasLoadedHistory,
            _that.errorMsg,
            _that.historyErrorMsg);
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
            SubmitLanguage selectedLanguage,
            Map<SubmitLanguage, String> draftCodeByLanguage,
            SubmissionStatus submissionStatus,
            String latestSubmittedCode,
            SubmitLanguage? latestSubmittedLanguage,
            DateTime? submittedAt,
            int submitCount,
            int score,
            List<String> feedbacks,
            List<SubmissionTestCaseResult> testCaseResults,
            List<SubmissionResult> previousSubmissions,
            String? submissionId,
            String? streamUrl,
            String? historyProblemId,
            String? latestVerdict,
            bool isSubmitting,
            bool isPolling,
            bool isHistoryLoading,
            bool hasLoadedHistory,
            String errorMsg,
            String historyErrorMsg)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState():
        return $default(
            _that.selectedLanguage,
            _that.draftCodeByLanguage,
            _that.submissionStatus,
            _that.latestSubmittedCode,
            _that.latestSubmittedLanguage,
            _that.submittedAt,
            _that.submitCount,
            _that.score,
            _that.feedbacks,
            _that.testCaseResults,
            _that.previousSubmissions,
            _that.submissionId,
            _that.streamUrl,
            _that.historyProblemId,
            _that.latestVerdict,
            _that.isSubmitting,
            _that.isPolling,
            _that.isHistoryLoading,
            _that.hasLoadedHistory,
            _that.errorMsg,
            _that.historyErrorMsg);
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
            SubmitLanguage selectedLanguage,
            Map<SubmitLanguage, String> draftCodeByLanguage,
            SubmissionStatus submissionStatus,
            String latestSubmittedCode,
            SubmitLanguage? latestSubmittedLanguage,
            DateTime? submittedAt,
            int submitCount,
            int score,
            List<String> feedbacks,
            List<SubmissionTestCaseResult> testCaseResults,
            List<SubmissionResult> previousSubmissions,
            String? submissionId,
            String? streamUrl,
            String? historyProblemId,
            String? latestVerdict,
            bool isSubmitting,
            bool isPolling,
            bool isHistoryLoading,
            bool hasLoadedHistory,
            String errorMsg,
            String historyErrorMsg)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReportSubmitState() when $default != null:
        return $default(
            _that.selectedLanguage,
            _that.draftCodeByLanguage,
            _that.submissionStatus,
            _that.latestSubmittedCode,
            _that.latestSubmittedLanguage,
            _that.submittedAt,
            _that.submitCount,
            _that.score,
            _that.feedbacks,
            _that.testCaseResults,
            _that.previousSubmissions,
            _that.submissionId,
            _that.streamUrl,
            _that.historyProblemId,
            _that.latestVerdict,
            _that.isSubmitting,
            _that.isPolling,
            _that.isHistoryLoading,
            _that.hasLoadedHistory,
            _that.errorMsg,
            _that.historyErrorMsg);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReportSubmitState implements ReportSubmitState {
  const _ReportSubmitState(
      {required this.selectedLanguage,
      required final Map<SubmitLanguage, String> draftCodeByLanguage,
      this.submissionStatus = SubmissionStatus.notSubmitted,
      this.latestSubmittedCode = '',
      this.latestSubmittedLanguage,
      this.submittedAt,
      this.submitCount = 0,
      this.score = 0,
      final List<String> feedbacks = const <String>[],
      final List<SubmissionTestCaseResult> testCaseResults =
          const <SubmissionTestCaseResult>[],
      final List<SubmissionResult> previousSubmissions =
          const <SubmissionResult>[],
      this.submissionId,
      this.streamUrl,
      this.historyProblemId,
      this.latestVerdict,
      this.isSubmitting = false,
      this.isPolling = false,
      this.isHistoryLoading = false,
      this.hasLoadedHistory = false,
      this.errorMsg = '',
      this.historyErrorMsg = ''})
      : _draftCodeByLanguage = draftCodeByLanguage,
        _feedbacks = feedbacks,
        _testCaseResults = testCaseResults,
        _previousSubmissions = previousSubmissions;

  @override
  final SubmitLanguage selectedLanguage;
  final Map<SubmitLanguage, String> _draftCodeByLanguage;
  @override
  Map<SubmitLanguage, String> get draftCodeByLanguage {
    if (_draftCodeByLanguage is EqualUnmodifiableMapView)
      return _draftCodeByLanguage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_draftCodeByLanguage);
  }

  @override
  @JsonKey()
  final SubmissionStatus submissionStatus;
  @override
  @JsonKey()
  final String latestSubmittedCode;
  @override
  final SubmitLanguage? latestSubmittedLanguage;
  @override
  final DateTime? submittedAt;
  @override
  @JsonKey()
  final int submitCount;
  @override
  @JsonKey()
  final int score;
  final List<String> _feedbacks;
  @override
  @JsonKey()
  List<String> get feedbacks {
    if (_feedbacks is EqualUnmodifiableListView) return _feedbacks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feedbacks);
  }

  final List<SubmissionTestCaseResult> _testCaseResults;
  @override
  @JsonKey()
  List<SubmissionTestCaseResult> get testCaseResults {
    if (_testCaseResults is EqualUnmodifiableListView) return _testCaseResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testCaseResults);
  }

  final List<SubmissionResult> _previousSubmissions;
  @override
  @JsonKey()
  List<SubmissionResult> get previousSubmissions {
    if (_previousSubmissions is EqualUnmodifiableListView)
      return _previousSubmissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousSubmissions);
  }

  @override
  final String? submissionId;
  @override
  final String? streamUrl;
  @override
  final String? historyProblemId;
  @override
  final String? latestVerdict;
  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  @JsonKey()
  final bool isPolling;
  @override
  @JsonKey()
  final bool isHistoryLoading;
  @override
  @JsonKey()
  final bool hasLoadedHistory;
  @override
  @JsonKey()
  final String errorMsg;
  @override
  @JsonKey()
  final String historyErrorMsg;

  /// Create a copy of ReportSubmitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReportSubmitStateCopyWith<_ReportSubmitState> get copyWith =>
      __$ReportSubmitStateCopyWithImpl<_ReportSubmitState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReportSubmitState &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            const DeepCollectionEquality()
                .equals(other._draftCodeByLanguage, _draftCodeByLanguage) &&
            (identical(other.submissionStatus, submissionStatus) ||
                other.submissionStatus == submissionStatus) &&
            (identical(other.latestSubmittedCode, latestSubmittedCode) ||
                other.latestSubmittedCode == latestSubmittedCode) &&
            (identical(
                    other.latestSubmittedLanguage, latestSubmittedLanguage) ||
                other.latestSubmittedLanguage == latestSubmittedLanguage) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.submitCount, submitCount) ||
                other.submitCount == submitCount) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality()
                .equals(other._feedbacks, _feedbacks) &&
            const DeepCollectionEquality()
                .equals(other._testCaseResults, _testCaseResults) &&
            const DeepCollectionEquality()
                .equals(other._previousSubmissions, _previousSubmissions) &&
            (identical(other.submissionId, submissionId) ||
                other.submissionId == submissionId) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.historyProblemId, historyProblemId) ||
                other.historyProblemId == historyProblemId) &&
            (identical(other.latestVerdict, latestVerdict) ||
                other.latestVerdict == latestVerdict) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.isPolling, isPolling) ||
                other.isPolling == isPolling) &&
            (identical(other.isHistoryLoading, isHistoryLoading) ||
                other.isHistoryLoading == isHistoryLoading) &&
            (identical(other.hasLoadedHistory, hasLoadedHistory) ||
                other.hasLoadedHistory == hasLoadedHistory) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg) &&
            (identical(other.historyErrorMsg, historyErrorMsg) ||
                other.historyErrorMsg == historyErrorMsg));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        selectedLanguage,
        const DeepCollectionEquality().hash(_draftCodeByLanguage),
        submissionStatus,
        latestSubmittedCode,
        latestSubmittedLanguage,
        submittedAt,
        submitCount,
        score,
        const DeepCollectionEquality().hash(_feedbacks),
        const DeepCollectionEquality().hash(_testCaseResults),
        const DeepCollectionEquality().hash(_previousSubmissions),
        submissionId,
        streamUrl,
        historyProblemId,
        latestVerdict,
        isSubmitting,
        isPolling,
        isHistoryLoading,
        hasLoadedHistory,
        errorMsg,
        historyErrorMsg
      ]);

  @override
  String toString() {
    return 'ReportSubmitState(selectedLanguage: $selectedLanguage, draftCodeByLanguage: $draftCodeByLanguage, submissionStatus: $submissionStatus, latestSubmittedCode: $latestSubmittedCode, latestSubmittedLanguage: $latestSubmittedLanguage, submittedAt: $submittedAt, submitCount: $submitCount, score: $score, feedbacks: $feedbacks, testCaseResults: $testCaseResults, previousSubmissions: $previousSubmissions, submissionId: $submissionId, streamUrl: $streamUrl, historyProblemId: $historyProblemId, latestVerdict: $latestVerdict, isSubmitting: $isSubmitting, isPolling: $isPolling, isHistoryLoading: $isHistoryLoading, hasLoadedHistory: $hasLoadedHistory, errorMsg: $errorMsg, historyErrorMsg: $historyErrorMsg)';
  }
}

/// @nodoc
abstract mixin class _$ReportSubmitStateCopyWith<$Res>
    implements $ReportSubmitStateCopyWith<$Res> {
  factory _$ReportSubmitStateCopyWith(
          _ReportSubmitState value, $Res Function(_ReportSubmitState) _then) =
      __$ReportSubmitStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SubmitLanguage selectedLanguage,
      Map<SubmitLanguage, String> draftCodeByLanguage,
      SubmissionStatus submissionStatus,
      String latestSubmittedCode,
      SubmitLanguage? latestSubmittedLanguage,
      DateTime? submittedAt,
      int submitCount,
      int score,
      List<String> feedbacks,
      List<SubmissionTestCaseResult> testCaseResults,
      List<SubmissionResult> previousSubmissions,
      String? submissionId,
      String? streamUrl,
      String? historyProblemId,
      String? latestVerdict,
      bool isSubmitting,
      bool isPolling,
      bool isHistoryLoading,
      bool hasLoadedHistory,
      String errorMsg,
      String historyErrorMsg});
}

/// @nodoc
class __$ReportSubmitStateCopyWithImpl<$Res>
    implements _$ReportSubmitStateCopyWith<$Res> {
  __$ReportSubmitStateCopyWithImpl(this._self, this._then);

  final _ReportSubmitState _self;
  final $Res Function(_ReportSubmitState) _then;

  /// Create a copy of ReportSubmitState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectedLanguage = null,
    Object? draftCodeByLanguage = null,
    Object? submissionStatus = null,
    Object? latestSubmittedCode = null,
    Object? latestSubmittedLanguage = freezed,
    Object? submittedAt = freezed,
    Object? submitCount = null,
    Object? score = null,
    Object? feedbacks = null,
    Object? testCaseResults = null,
    Object? previousSubmissions = null,
    Object? submissionId = freezed,
    Object? streamUrl = freezed,
    Object? historyProblemId = freezed,
    Object? latestVerdict = freezed,
    Object? isSubmitting = null,
    Object? isPolling = null,
    Object? isHistoryLoading = null,
    Object? hasLoadedHistory = null,
    Object? errorMsg = null,
    Object? historyErrorMsg = null,
  }) {
    return _then(_ReportSubmitState(
      selectedLanguage: null == selectedLanguage
          ? _self.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as SubmitLanguage,
      draftCodeByLanguage: null == draftCodeByLanguage
          ? _self._draftCodeByLanguage
          : draftCodeByLanguage // ignore: cast_nullable_to_non_nullable
              as Map<SubmitLanguage, String>,
      submissionStatus: null == submissionStatus
          ? _self.submissionStatus
          : submissionStatus // ignore: cast_nullable_to_non_nullable
              as SubmissionStatus,
      latestSubmittedCode: null == latestSubmittedCode
          ? _self.latestSubmittedCode
          : latestSubmittedCode // ignore: cast_nullable_to_non_nullable
              as String,
      latestSubmittedLanguage: freezed == latestSubmittedLanguage
          ? _self.latestSubmittedLanguage
          : latestSubmittedLanguage // ignore: cast_nullable_to_non_nullable
              as SubmitLanguage?,
      submittedAt: freezed == submittedAt
          ? _self.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      submitCount: null == submitCount
          ? _self.submitCount
          : submitCount // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _self.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      feedbacks: null == feedbacks
          ? _self._feedbacks
          : feedbacks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testCaseResults: null == testCaseResults
          ? _self._testCaseResults
          : testCaseResults // ignore: cast_nullable_to_non_nullable
              as List<SubmissionTestCaseResult>,
      previousSubmissions: null == previousSubmissions
          ? _self._previousSubmissions
          : previousSubmissions // ignore: cast_nullable_to_non_nullable
              as List<SubmissionResult>,
      submissionId: freezed == submissionId
          ? _self.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      streamUrl: freezed == streamUrl
          ? _self.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      historyProblemId: freezed == historyProblemId
          ? _self.historyProblemId
          : historyProblemId // ignore: cast_nullable_to_non_nullable
              as String?,
      latestVerdict: freezed == latestVerdict
          ? _self.latestVerdict
          : latestVerdict // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _self.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      isPolling: null == isPolling
          ? _self.isPolling
          : isPolling // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _self.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasLoadedHistory: null == hasLoadedHistory
          ? _self.hasLoadedHistory
          : hasLoadedHistory // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMsg: null == errorMsg
          ? _self.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
      historyErrorMsg: null == historyErrorMsg
          ? _self.historyErrorMsg
          : historyErrorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
