import 'package:cat_pragma/app/core/config/config.dart';
import 'package:dio/dio.dart';

class ErrorsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppConfig.logError(err, err.stackTrace);

    if (err.type == DioExceptionType.connectionTimeout) {
    } else if (err.type == DioExceptionType.receiveTimeout) {
    } else if (err.type == DioExceptionType.sendTimeout) {
    } else if (err.type == DioExceptionType.badResponse) {
      switch (err.response?.statusCode) {
        case 404:
          break;
        case 500:
          break;
        default:
          var message = err.response?.data['error'] ?? err.response?.data['message'];
          if (message != null) {}
      }
    } else if (err.type == DioExceptionType.unknown) {}

    return super.onError(err, handler);
  }
}
