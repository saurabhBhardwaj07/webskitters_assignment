import 'package:dio/dio.dart';

final dio = _instance();

Dio _instance() {
  var dio = Dio();
  dio.options.responseType = ResponseType.json;
  dio.options.baseUrl = "https://api.unsplash.com/";

  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['accept'] = 'application/json';
    return handler.next(options);
  }, onError: (DioException e, handler) async {
    print('${e.message} message');
    print('${e.response} response');

    return handler.next(e);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }));

  dio.interceptors.add(LogInterceptor(
      requestBody: true, responseBody: true, requestHeader: true));
  return dio;
}
