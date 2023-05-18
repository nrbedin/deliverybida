import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:deliverydigital/src/core/exceptions/repository_exception.dart';
import 'package:deliverydigital/src/core/exceptions/unathorized_exception.dart';
import 'package:deliverydigital/src/core/rest_client/custom_dio.dart';
import 'package:deliverydigital/src/models/auth_model.dart';
import 'package:deliverydigital/src/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  CustomDio _dio;

  AuthRepositoryImpl(this._dio);
  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await _dio.unauth().post(
        'auth',
        data: {
          'email': email,
          'password': password,
          'admin': true,
        },
      );

      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Login ou senha inválidos', error: e, stackTrace: s);
        throw UnathorizedException();
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
      ;
    }
  }
}
