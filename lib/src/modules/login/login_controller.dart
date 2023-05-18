import 'dart:developer';

import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/core/exceptions/unathorized_exception.dart';
import 'package:deliverydigital/src/services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  var _loginStatus = LoginStateStatus.initial;

  @readonly
  String? _erroMessage;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _loginStatus = LoginStateStatus.loading;
      await _loginService.execute(email, password);
      _loginStatus = LoginStateStatus.success;
    } on UnathorizedException catch (e) {
      _erroMessage = 'Login ou senha inválidos';
      _loginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _erroMessage = 'Tente novamente mais tarde';
      _loginStatus = LoginStateStatus.error;
    }
  }
}
