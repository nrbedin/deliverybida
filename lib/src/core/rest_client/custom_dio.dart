import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import 'package:deliverydigital/src/core/env/env.dart';
import 'package:deliverydigital/src/core/rest_client/interceptors/auth_interceptor.dart';
import 'package:deliverydigital/src/core/storage/storage.dart';

class CustomDio extends DioForBrowser {
  late AuthInterceptor _authInterceptor;

  CustomDio(Storage storage)
      : super(BaseOptions(
          baseUrl: Env.instance.get('backend_base_url'),
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 60),
        )) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptor = AuthInterceptor(storage);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
