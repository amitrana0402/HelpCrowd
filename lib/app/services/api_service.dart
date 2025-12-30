import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../core/constants/api_constants.dart';
import '../data/models/api_error_model.dart';

class ApiService extends GetxService {
  late Dio _dio;
  final String baseUrl;

  ApiService({Dio? dio, String? baseUrl})
    : baseUrl = baseUrl ?? ApiConstants.baseUrl {
    _dio =
        dio ??
        Dio(
          BaseOptions(
            baseUrl: baseUrl ?? ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              'accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        );

    // Add interceptors for logging (optional, useful for debugging)
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  Future<ApiService> init() async {
    return this;
  }

  // Helper method to get headers
  Map<String, dynamic> _getHeaders({
    Map<String, String>? additionalHeaders,
    bool includeCsrf = false,
  }) {
    final headers = <String, dynamic>{};

    if (includeCsrf) {
      // TODO: Get CSRF token from storage if needed
      headers['X-CSRF-TOKEN'] = '';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  // Handle DioException and convert to ApiException
  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          'Request timeout. Please check your internet connection.',
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        if (responseData != null && responseData is Map<String, dynamic>) {
          try {
            final errorModel = ApiErrorModel.fromJson(responseData, statusCode);
            return ApiException.fromErrorModel(errorModel);
          } catch (e) {
            return ApiException(
              responseData['message']?.toString() ??
                  'Request failed with status $statusCode',
              statusCode: statusCode,
            );
          }
        }
        return ApiException(
          'Request failed with status $statusCode',
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return ApiException('Request was cancelled', statusCode: 0);

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiException(
            'No internet connection. Please check your network settings.',
            statusCode: 0,
          );
        }
        return ApiException(
          'An unexpected error occurred: ${error.error?.toString() ?? "Unknown error"}',
          statusCode: 0,
        );

      case DioExceptionType.badCertificate:
        return ApiException(
          'SSL certificate error. Please check your connection.',
          statusCode: 0,
        );

      case DioExceptionType.connectionError:
        return ApiException(
          'Connection error. Please check your internet connection.',
          statusCode: 0,
        );
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? additionalHeaders,
    bool includeCsrf = false,
  }) async {
    try {
      final headers = _getHeaders(
        additionalHeaders: additionalHeaders,
        includeCsrf: includeCsrf,
      );

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final headers = _getHeaders(additionalHeaders: additionalHeaders);

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final headers = _getHeaders(additionalHeaders: additionalHeaders);

      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? additionalHeaders,
  }) async {
    try {
      final headers = _getHeaders(additionalHeaders: additionalHeaders);

      final response = await _dio.delete(
        endpoint,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException(
        'An unexpected error occurred: ${e.toString()}',
        statusCode: 0,
      );
    }
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final ApiErrorModel? errorModel;

  ApiException(this.message, {this.statusCode, this.errorModel});

  factory ApiException.fromErrorModel(ApiErrorModel errorModel) {
    return ApiException(
      errorModel.message,
      statusCode: errorModel.statusCode,
      errorModel: errorModel,
    );
  }

  @override
  String toString() => message;
}
