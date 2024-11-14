// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:marketplace/core/services/user_storage_service.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({
    this.logger,
    required this.storageService,
  });

  final Logger? logger;
  final UserStorageService storageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logger?.i('REQUEST[${options.method}] => URL: ${options.uri}\n'
        'REQUEST DATA => ${options.data}\n'
        'Headers: ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    logger?.i(
      'RESPONSE[${response.statusCode}] =>'
      ' PATH:${response.requestOptions.path}\n'
      'RESPONSE DATA: ${response.data}',
    );
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logger?.e('ERROR[${err.requestOptions.uri}]\n'
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\n'
        'ERROR[${err.response?.data}]');
    super.onError(err, handler);
  }
}

class TokenInterceptor extends Interceptor {
  TokenInterceptor(
      {
    required this.storageService}
      );

  final UserStorageService storageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final someToken = storageService.getToken() ?? '';
    options.headers['Authorization'] = 'Bearer $someToken';
    super.onRequest(options, handler);
  }
}

class DataParserInterceptor extends Interceptor {
  DataParserInterceptor();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    late Response<dynamic> modifiedResponse;
    try {
      if (response.requestOptions.path.contains('/locator/v2/stores/search')) {
        final data = (response.data as Map<String, dynamic>)['storeList'];
        modifiedResponse = Response<dynamic>(
          requestOptions: response.requestOptions,
          data: data,
          statusCode: response.statusCode,
          extra: response.extra,
          headers: response.headers,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
          statusMessage: response.statusMessage,
        );
      } else {
        modifiedResponse = response;
      }
    } catch (e) {
      modifiedResponse = response;
    }

    super.onResponse(modifiedResponse, handler);
  }
}

class CurlInterceptor extends Interceptor {
  CurlInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final url = options.uri.toString();
    final headers = options.headers;
    final data = options.data;

    var curlCommand = "curl -X ${options.method} '$url' \\";

    headers.forEach((key, value) {
      curlCommand += "\n-H '$key: $value' \\";
    });

    if (data != null) {
      if (data is Map) {
        final encodedData = json.encode(data);
        curlCommand += "\n--data-raw '$encodedData' \\";
      } else {
        curlCommand += "\n--data-raw '$data'";
      }
    } else {
      curlCommand += "\n--data-raw '{}'";
    }

    log('\n\n============[CURL COMMAND]=====================\n'
        '$curlCommand\n'
        '==============================================');

    super.onRequest(options, handler);
  }
}
