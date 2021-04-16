import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/config/api.dart';
import 'package:flutter_wanandroid/config/global_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart' as SynchronizedLock;

import 'error_entity.dart';
import 'http_result.dart';

class DioManager {
  static Dio _dio;

  static DioManager _instance;

  static PersistCookieJar _cookieJar;

  static SynchronizedLock.Lock _lock = SynchronizedLock.Lock();

  DioManager._();

  static Future<DioManager> getInstance() async {
    if (_instance == null) {
      _instance = DioManager._();
      await _getCookieJar();
      await init();
      // await _lock.synchronized(() async {
      //   if (_instance == null) {
      //     _instance = DioManager._();
      //     await _getCookieJar();
      //     await init();
      //   }
      // });
    }
    return _instance;
  }

  static Future init() async {
    var options = BaseOptions(
        baseUrl: API.BASE_URL,
        connectTimeout: 10000,
        receiveTimeout: 3000,
        contentType: Headers.formUrlEncodedContentType);
    _dio = Dio(options);
    _dio.interceptors
        .add(LogInterceptor(responseBody: GlobalConfig.isDebug)); //是否开启请求日志
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  static Future<PersistCookieJar> _getCookieJar() async {
    if (_cookieJar == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _cookieJar = new PersistCookieJar(storage: FileStorage(appDocDir.path));
    }
    return _cookieJar;
  }

  static clearCookie() => _cookieJar.deleteAll();

  //-------------------------------get、post请求方法封装--------------------------------//

  /// Get请求
  static get<T>(String url, Map<String, dynamic> params, Function(T) success,
      Function(ErrorEntity) error) async {
    _instance._requstHttp("get", url, params, success, error);
  }

  /// Post请求
  static post<T>(String url, Map<String, dynamic> params, Function(T) success,
      Function(ErrorEntity) error) async {
    _instance._requstHttp("post", url, params, success, error);
  }

  /// 实际请求的方法
  _requstHttp<T>(String method, String url,
      [Map<String, dynamic> params,
      Function(T) success,
      Function(ErrorEntity) error]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null && params.isNotEmpty) {
          response = await _dio.get(url, queryParameters: params);
        } else {
          response = await _dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.isNotEmpty) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      }
      if (response != null && response.statusCode == HttpStatus.ok) {
        if (response.data is String) {
          response.data = json.decode(response.data);
        }
        HttpResult result = HttpResult<T>.fromJson(
            "errorCode", "errorMsg", "data", response.data);
        if (result.state == 0) {
          success(result.data);
        } else {
          error(ErrorEntity(errorCode: result.state, errorMsg: result.message));
        }
      } else {
        error(ErrorEntity(errorCode: -1, errorMsg: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorEntity(e));
    }
  }

  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求取消");
        }
        break;
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "连接超时");
        }
        break;
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "请求超时");
        }
        break;
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(errorCode: -1, errorMsg: "响应超时");
        }
        break;
      case DioErrorType.response:
        {
          try {
            int errCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return ErrorEntity(errorCode: errCode, errorMsg: errMsg);
          } on Exception catch (_) {
            return ErrorEntity(errorCode: -1, errorMsg: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(errorCode: -1, errorMsg: error.message);
        }
    }
  }
}
