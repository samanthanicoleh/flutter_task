import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api.dart';
import '../models/api_error.dart';

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}

final dioServiceProvider = Provider<DioService>((ref) => DioService());

class DioService {
  DioService() {
    dio = Dio();
    dio.options.baseUrl = AppEndpoints.baseUrl;
    dio.options.sendTimeout = 30000;
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
  }

  late final Dio dio;

  // Request method used on all api calls
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
    required T Function(dynamic data) builder,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? passedData,
    String? token,
  }) async {
    try {
      dynamic data;
      data = passedData != null ? jsonEncode(passedData) : null;

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        method: method.name,
      );

      final Response response;

      switch (method) {
        case HttpMethod.get:
          response = await dio.get(
            url,
            options: options,
            queryParameters: parameters,
          );
          break;
        case HttpMethod.post:
          response = await dio.post(
            url,
            data: data,
            options: options,
          );
          break;
        case HttpMethod.put:
          response = await dio.put(
            url,
            data: data,
            options: options,
          );
          break;
        case HttpMethod.delete:
          response = await dio.delete(
            url,
            data: data,
            options: options,
          );
          break;
        case HttpMethod.patch:
          response = await dio.patch(
            url,
            data: data,
            options: options,
          );
          break;
        default:
          response = await dio.get(
            url,
            options: options,
          );
          break;
      }

      return builder(response.data);
    } on DioError catch (e) {
      final errorData = e.response?.data;

      throw ApiError.fromJson(errorData);
    }
  }
}
