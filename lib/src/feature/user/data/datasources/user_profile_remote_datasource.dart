import 'dart:typed_data';

import 'package:aandi_auth/aandi_auth.dart' as auth_api;
import 'package:a_and_i_report_web_server/src/core/models/user.dart';
import 'package:dio/dio.dart';

/// 내 정보 수정 네트워크 오류다.
class UpdateMyProfileNetworkException implements Exception {}

/// 내 정보 수정 요청/응답 오류다.
class UpdateMyProfileRequestException implements Exception {}

/// 비밀번호 변경 네트워크 오류다.
class ChangePasswordNetworkException implements Exception {}

/// 비밀번호 변경 요청/응답 오류다.
class ChangePasswordRequestException implements Exception {}

/// 사용자 프로필 원격 데이터소스다.
class UserProfileRemoteDatasource {
  UserProfileRemoteDatasource({
    required auth_api.AuthRepository repository,
    Dio? uploadDio,
  })  : _repository = repository,
        _uploadDio = uploadDio ?? Dio();

  final auth_api.AuthRepository _repository;
  final Dio _uploadDio;

  /// `/v2/me` 내 정보 수정 API를 호출한다.
  Future<User?> updateMyProfile({
    required String authorization,
    String? nickname,
    Uint8List? profileImageBytes,
    String? profileImageFileName,
    String? profileImageMimeType,
  }) async {
    try {
      final _ = authorization;
      final trimmedNickname = nickname?.trim();
      final hasNickname = trimmedNickname != null && trimmedNickname.isNotEmpty;
      final hasProfileImage =
          profileImageBytes != null && profileImageBytes.isNotEmpty;

      if (!hasNickname && !hasProfileImage) {
        throw UpdateMyProfileRequestException();
      }

      String? profileImageUrl;
      if (hasProfileImage) {
        profileImageUrl = await _uploadProfileImage(
          profileImageBytes: profileImageBytes,
          profileImageFileName: profileImageFileName ??
              _resolveDefaultFileName(profileImageMimeType),
          profileImageMimeType:
              _resolveMimeType(profileImageMimeType, profileImageFileName),
        );
      }

      final response = await _repository.updateProfileV2(
        nickname: hasNickname ? trimmedNickname : null,
        profileImageUrl: profileImageUrl,
      );

      return User(
        id: response.id,
        role: response.role.toApi(),
        nickname: _resolveNickname(
          nickname: response.nickname,
          username: response.username,
        ),
        profileImageUrl: response.profileImageUrl,
        publicCode: response.publicCode,
      );
    } on auth_api.AuthApiException catch (error) {
      if (_isNetworkLike(error.statusCode)) {
        throw UpdateMyProfileNetworkException();
      }
      throw UpdateMyProfileRequestException();
    } on DioException catch (error) {
      if (_isDioNetworkError(error)) {
        throw UpdateMyProfileNetworkException();
      }
      throw UpdateMyProfileRequestException();
    } on UpdateMyProfileRequestException {
      rethrow;
    } catch (_) {
      throw UpdateMyProfileRequestException();
    }
  }

  /// `/v2/me/password` 비밀번호 변경 API를 호출한다.
  Future<void> changePassword({
    required String authorization,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final _ = authorization;
      final trimmedCurrentPassword = currentPassword.trim();
      final trimmedNewPassword = newPassword.trim();

      if (trimmedCurrentPassword.isEmpty || trimmedNewPassword.isEmpty) {
        throw ChangePasswordRequestException();
      }

      final changed = await _repository.changePasswordV2(
        currentPassword: trimmedCurrentPassword,
        newPassword: trimmedNewPassword,
      );

      if (!changed) {
        throw ChangePasswordRequestException();
      }
    } on auth_api.AuthApiException catch (error) {
      if (_isNetworkLike(error.statusCode)) {
        throw ChangePasswordNetworkException();
      }
      throw ChangePasswordRequestException();
    } on ChangePasswordRequestException {
      rethrow;
    } catch (_) {
      throw ChangePasswordRequestException();
    }
  }

  Future<String> _uploadProfileImage({
    required Uint8List profileImageBytes,
    required String profileImageFileName,
    required String profileImageMimeType,
  }) async {
    final upload = await _repository.requestProfileImageUploadUrlV2(
      contentType: profileImageMimeType,
      fileName: profileImageFileName,
    );

    await _uploadDio.put<void>(
      upload.uploadUrl,
      data: profileImageBytes,
      options: Options(
        headers: <String, String>{
          'Content-Type': profileImageMimeType,
        },
      ),
    );

    return upload.profileImageUrl;
  }

  String _resolveDefaultFileName(String? mimeType) {
    if (mimeType == null || mimeType.isEmpty) {
      return 'profile.jpg';
    }
    if (mimeType.contains('webp')) {
      return 'profile.webp';
    }
    if (mimeType.contains('png')) {
      return 'profile.png';
    }
    return 'profile.jpg';
  }

  String _resolveMimeType(String? mimeType, String? fileName) {
    final trimmedMimeType = mimeType?.trim();
    if (trimmedMimeType != null && trimmedMimeType.isNotEmpty) {
      return trimmedMimeType;
    }

    final lowerFileName = fileName?.toLowerCase() ?? '';
    if (lowerFileName.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerFileName.endsWith('.webp')) {
      return 'image/webp';
    }
    return 'image/jpeg';
  }

  bool _isNetworkLike(int? statusCode) => statusCode == null;

  bool _isDioNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.unknown;
  }
}

String _resolveNickname({
  required String? nickname,
  required String username,
}) {
  final trimmedNickname = nickname?.trim();
  if (trimmedNickname != null && trimmedNickname.isNotEmpty) {
    return trimmedNickname;
  }

  final trimmedUsername = username.trim();
  if (trimmedUsername.isNotEmpty) {
    return trimmedUsername;
  }

  return '동아리원';
}
