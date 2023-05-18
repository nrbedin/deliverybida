import 'package:deliverydigital/src/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login(String email, String password);
}
