import 'package:dio/dio.dart';
import '../../constants/consts.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstant.BASE_URL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    String lang = 'en',
    Map<String, dynamic>? query,
    String? token = "",
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> post({
    required String url,
    Map<String, dynamic>? data,
    FormData? formData,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    Function(int, int)? onSendProgress,
    bool? isProfileImage = false,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer ${token ?? ""}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio?.post(
      url,
      data: isProfileImage! ? formData : data,
      queryParameters: query,
      onSendProgress: onSendProgress,
    );
  }

  static Future<Response?> patch({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': 'Bearer ${token ?? ""}',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/x-www-form-urlencoded',
    };
    return dio?.patch(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response?> delete({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) {
    dio?.options.headers = {
      'Authorization': 'Bearer ${token ?? ""}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return dio!.delete(url, data: data, queryParameters: query);
  }
}
