import 'package:dio/dio.dart';

import 'package:deliverydigital/src/core/global/constants.dart';
import 'package:deliverydigital/src/core/global/global_context.dart';
import 'package:deliverydigital/src/core/storage/storage.dart';

class AuthInterceptor extends Interceptor {
  final Storage storage;
  AuthInterceptor(
    this.storage,
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = storage.getData(SessionStorageKeys.access_token.key);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      GlobalContext.instance.loginExpire();
    } else {
      handler.next(err);
    }
  }
}
