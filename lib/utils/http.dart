import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:ledger/utils/path.dart';
import 'package:sp_util/sp_util.dart';

class XHttp {
  XHttp._internal();
  static final envPath = "http://www.smyxcoding.top"; // 测试
  ///网络请求配置
  static final Dio dio = Dio(BaseOptions(
    // baseUrl: "http://www.smyxcoding.top", // 服务器
    baseUrl: "http://101.132.162.59:37001/dserver", // 本地
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));

  ///初始化dio
  static init() {
    ///初始化cookie
    PathUtils.getDocumentsDirPath().then((value) {
      var cookieJar = PersistCookieJar(dir: value + "/.cookies/");
      dio.interceptors.add(CookieManager(cookieJar));
    });

    //添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      String xToken = '';
      String userToken = '';
      var userInfo = SpUtil.getObject('loggedUser');
      if (null != userInfo) {
        xToken = userInfo['token'].toString();
        var content = new Utf8Encoder().convert(xToken + 'ledger');
        var digest = md5.convert(content);
        userToken = hex.encode(digest.bytes).toString();
      }
      options.headers.addAll({
        'X-Token': xToken,
        'User-Token': userToken,
        // "Content-Type":"application/json;charset=utf-8"
      });
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) {
      handleError(e);
      return e;
    }));
  }

  ///error统一处理
  static void handleError(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        break;
      case DioErrorType.SEND_TIMEOUT:
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        break;
      case DioErrorType.RESPONSE:
        break;
      case DioErrorType.CANCEL:
        break;
      default:
        break;
    }
  }

  ///get请求
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  ///post 表单请求
  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  ///post body请求
  static Future postJson<T>(String url, {Map<String, dynamic> data}) async {
    final options =
        Options(method: "post", contentType: "application/json;charset=utf-8");
    Response response = await dio.request(url, data: data, options: options);
    return response.data;
  }

  ///post 富文本请求
  static Future postEditJson(String url, [Map<String, dynamic> params]) async {
    final options =
        Options(method: "post", contentType: "application/json;charset=utf-8");
    Response response =
        await dio.request(url, queryParameters: params, options: options);
    return response.data;
  }

  // 上传头像请求
  static Future postFile(String url, FormData data) async {
    Response response = await dio.post<String>(url, data: data);
    return response.data;
  }

  ///下载文件
  static Future downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {});
    } on DioError catch (e) {
      handleError(e);
    }
    return response.data;
  }
}
