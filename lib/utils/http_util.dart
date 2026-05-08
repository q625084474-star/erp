import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  
  late Dio _dio;
  Dio get dio => _dio;
  
  HttpUtil._internal() {
    // 基础配置
    BaseOptions options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    
    _dio = Dio(options);
    
    // 请求拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 添加Token
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 统一处理响应
        if (response.data is Map) {
          final data = response.data as Map;
          if (data['code'] == 200 || data['code'] == 0) {
            return handler.next(response);
          } else {
            // 业务错误
            final message = data['message'] ?? data['msg'] ?? '请求失败';
            Fluttertoast.showToast(msg: message);
            return handler.reject(DioException(
              requestOptions: response.requestOptions,
              response: response,
              type: DioExceptionType.badResponse,
            ));
          }
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        String message = '网络错误';
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.sendTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          message = '网络连接超时';
        } else if (error.type == DioExceptionType.connectionError) {
          message = '网络连接失败';
        } else if (error.response?.statusCode == 401) {
          message = '登录已过期，请重新登录';
          // TODO: 跳转登录页
        } else if (error.response?.statusCode == 403) {
          message = '没有权限访问';
        } else if (error.response?.statusCode == 404) {
          message = '请求的资源不存在';
        } else if (error.response?.statusCode == 500) {
          message = '服务器错误';
        }
        Fluttertoast.showToast(msg: message);
        return handler.next(error);
      },
    ));
    
    // 日志拦截器（调试模式）
    if (AppConfig.isDebug) {
      _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ));
    }
  }
  
  // GET请求
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    return await _dio.get(path, queryParameters: params);
  }
  
  // POST请求
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
  
  // PUT请求
  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }
  
  // DELETE请求
  Future<Response> delete(String path, {Map<String, dynamic>? params}) async {
    return await _dio.delete(path, queryParameters: params);
  }
  
  // 上传文件
  Future<Response> upload(String path, String filePath, {String? name}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });
    return await _dio.post(path, data: formData);
  }
  
  // 下载文件
  Future<Response> download(String url, String savePath) async {
    return await _dio.download(url, savePath);
  }
}
