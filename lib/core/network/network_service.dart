import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import '../../injection_container.dart';
import '../blocs/selected_language_cubit.dart';

abstract class NetworkService<T> {
  Future<T> get(
      {required String endpoint, Map<String, dynamic>? queryParameters});
  Future<T> post(
      {required String endpoint, dynamic data, Map<String, dynamic>? headers});
}

class DioNetworkService extends NetworkService<Response> {
  final DioAppInterceptors _appInterceptors;
  DioNetworkService(this._appInterceptors);

  Dio get _dio {
    var dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveTimeout: AppConstants.dioTimeout,
      connectTimeout: AppConstants.dioTimeout,
      sendTimeout: AppConstants.dioTimeout,
    ));

    dio.interceptors.addAll({_appInterceptors});
    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return dio;
  }

  @override
  Future<Response> get(
          {required String endpoint, Map<String, dynamic>? queryParameters}) =>
      _dio.get(endpoint, queryParameters: queryParameters, options: Options());

  @override
  Future<Response> post(
          {required String endpoint,
          dynamic data,
          Map<String, dynamic>? headers}) =>
      _dio.post(endpoint,
          data: data,
          options: headers != null ? Options(headers: headers) : null);
}

class DioAppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final AuthCubit authCubit = getIt<AuthCubit>();
    final String selectedLanguage = getIt<SelectedLanguageCubit>().state;
    options.queryParameters.putIfAbsent('_lang', () => selectedLanguage);
    if (authCubit.state is Authenticated) {
      options.headers['Authorization'] =
          'token ${(authCubit.state as Authenticated).token}';
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
