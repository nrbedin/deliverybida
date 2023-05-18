import 'package:deliverydigital/src/core/exceptions/repository_exception.dart';
import 'package:deliverydigital/src/core/global/constants.dart';
import 'package:deliverydigital/src/core/storage/storage.dart';
import 'package:deliverydigital/src/repositories/auth/auth_repository.dart';
import 'package:deliverydigital/src/services/auth/login_service.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository _authRepository;
  final Storage _storage;
  LoginServiceImpl(
    this._authRepository,
    this._storage,
  );

  @override
  Future<void> execute(String email, String password) async {
    try {
      final authModel = await _authRepository.login(
        email,
        password,
      );
      _storage.setData(
        SessionStorageKeys.access_token.key,
        authModel.accessToken,
      );
    } on RepositoryException catch (e) {}
  }
}
