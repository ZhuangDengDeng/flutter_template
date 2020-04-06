import 'package:dio/dio.dart';
import 'package:flutter_template/config/constant.dart';
import 'package:flutter_template/utils/log_utils.dart';
import 'package:flutter_template/utils/request/intercpetors.dart';
import 'error_handle.dart';

enum Method { get, post, put, patch, delete, head }

class DioUtils {
  static DioUtils _instance = DioUtils._init();

  static DioUtils get instance => DioUtils();

  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  factory DioUtils() {
    if (_instance == null) {
      _instance = DioUtils._init();
    }
    return _instance;
  }

  DioUtils._init() {
    BaseOptions options = BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        responseType: ResponseType.json,
        baseUrl: Constant.baseUrl);
    _dio = Dio(options);

    //网络请求缓存
    _dio.interceptors.add(NetCache());

    _dio.interceptors.add(AuthInterceptor());

    //如果不是生产环境，开启日志
    if (!Constant.inProduction) {
      _dio.interceptors.add(LogInterceptor(requestBody: false));
    }
  }
  //检查options是否存在，如果不存在就new一个默认options
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future<Response<T>> _request<T>(String method, String url,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    Response<T> response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    return response;
  }

  Future requestNetwork<T>(
    Method method,
    String url, {
    Function(T t) onSuccess,
    Function(int code, String msg) onError,
    dynamic params,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  }) async {
    String m = _getRequestMethod(method);
    return await _request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((Response<T> result) {
      if (result.statusCode == 200 && onSuccess != null) {
        onSuccess(result.data);
      } else {
        _onError(result.statusCode, result.statusMessage, onError);
      }
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  asyncRequestNetwork<T>(Method method, String url,
      {Function(T t) onSuccess,
      Function(List<T> list) onSuccessList,
      Function(int code, String msg) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String m = _getRequestMethod(method);
    Stream.fromFuture(_request<T>(m, url,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      if (result.statusCode == 200 && onSuccess != null) {
        onSuccess(result.data);
      } else {
        _onError(result.statusCode, result.statusMessage, onError);
      }
    }, onError: (e) {
      _cancelLogPrint(e, url);
      NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      Log.e("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    if (code == null) {
      code = ExceptionHandle.unknown_error;
      msg = "未知异常";
    }
    Log.e("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method) {
    String m;
    switch (method) {
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}
