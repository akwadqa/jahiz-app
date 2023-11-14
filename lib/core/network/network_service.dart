import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../app_constants.dart';
import '../../features/auth/application/auth_cubit.dart';
import '../../generated/l10n.dart';
import '../../injection_container.dart';
import '../blocs/selected_language_cubit.dart';

abstract class NetworkService<T> {
  Future<T> get(
      {required String endpoint, Map<String, dynamic>? queryParameters});
  Future<T> post(
      {required String endpoint, dynamic data, Map<String, dynamic>? headers});
}

class DioNetworkService extends NetworkService<Response> {
  final Dio _dio;

  DioNetworkService(SelectedLanguageCubit selectedLanguageCubit, AuthCubit authCubit)
      : _dio = Dio(BaseOptions(
          baseUrl: AppConstants.baseUrl,
          receiveTimeout: AppConstants.dioTimeout,
          connectTimeout: AppConstants.dioTimeout,
          sendTimeout: AppConstants.dioTimeout,
        )) {
    _dio.interceptors.add(DioAppInterceptors(selectedLanguageCubit, authCubit));
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  @override
  Future<Response> get({required String endpoint, Map<String, dynamic>? queryParameters}) =>
      _dio.get(endpoint, queryParameters: queryParameters);

  @override
  Future<Response> post({required String endpoint, dynamic data, Map<String, dynamic>? headers}) =>
      _dio.post(endpoint, data: data, options: Options(headers: headers));
}

class DioAppInterceptors extends Interceptor {
 final SelectedLanguageCubit _selectedLanguageCubit;
  final AuthCubit _authCubit;

  DioAppInterceptors(this._selectedLanguageCubit, this._authCubit);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final selectedLanguage = _selectedLanguageCubit.state;
    final token = _authCubit.state is Authenticated ? (_authCubit.state as Authenticated).token : null;

    options.queryParameters['_lang'] = selectedLanguage;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      debugPrint(err.response!.data.toString());
    }
    final String? message = err.response?.data['message'];
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, message);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, message);
          case 401:
            throw UnauthorizedException(err.requestOptions, message);
          case 403:
            getIt<AuthCubit>().setUnauthenticated();
            throw AccessForbiddenException(err.requestOptions, message);
          case 404:
            throw NotFoundException(err.requestOptions, message);
          case 409:
            throw ConflictException(err.requestOptions, message);
          case 422:
            throw UnprocessableEntityException(err.requestOptions, message);
          case 500:
            throw InternalServerErrorException(err.requestOptions, message);
          default:
            throw BadResponseException(err.requestOptions, message);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions, message);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions, message);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions, message);
    }
    return handler.next(err);
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions requestOptions, [this.customMessage])
      : super(requestOptions: requestOptions, error: customMessage);

  final String? customMessage;

  String get defaultErrorString => S.current.requestError;

  @override
  String toString() {
    return customMessage ?? defaultErrorString;
  }
}

class BadRequestException extends ApiException {
  BadRequestException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.badRequest;
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.unprocessableEntity;
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.internalServerError;
}

class ConflictException extends ApiException {
  ConflictException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.conflictConnection;
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.unauthorized;
}

class NotFoundException extends ApiException {
  NotFoundException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.notFound;
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.noInternetConnection;
}

class DeadlineExceededException extends ApiException {
  DeadlineExceededException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.deadlineExceeded;
}

class AccessForbiddenException extends ApiException {
  AccessForbiddenException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => S.current.accessForbidden;
}

class BadCertificateException extends ApiException {
  BadCertificateException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString => S.current.badCertificate;
}

class ConnectionErrorException extends ApiException {
  ConnectionErrorException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString => S.current.connectionError;
}

class BadResponseException extends ApiException {
  BadResponseException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString => S.current.freiendlyErrorMessage;
}
