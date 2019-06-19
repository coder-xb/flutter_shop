import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import '../config/index.dart';

Future $http(String method, String url, {Map<String, dynamic> data}) async {
  Response response = Response();
  try {
    final Dio _client = Dio(BaseOptions(
      method: method,
      baseUrl: HttpAPI.baseURL,
      contentType: ContentType.parse('application/x-www-form-urlencoded'),
    ));
    response = data == null
        ? await _client.request(HttpAPI.API[url])
        : await _client.request(HttpAPI.API[url], data: data);

    return response.statusCode == HttpStatus.ok
        ? ApiResponse.fromJson(response.data)
        : ApiResponse(
            code: ApiResponse.resError,
            message: response.statusCode.toString(),
          );
  } catch (e) {
    return ApiResponse(
      code: ApiResponse.reqError,
      message: 'ERROR: $e',
    );
  }
}

class ApiResponse {
  static const int resError = -2;
  static const int reqError = -1;
  static const int success = 0;
  final int code;
  final String message;
  final dynamic data; // List || Map

  ApiResponse({this.code = success, this.message = '', this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json['code'] as int,
        message: json['message'] as String,
        data: json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json['data'] as List<dynamic>,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': this.code,
        'message': this.message,
        'data': this.data
      };
}
