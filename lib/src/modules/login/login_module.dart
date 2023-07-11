import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/modules/login/login_controller.dart';
import 'package:deliverydigital/src/modules/login/login_page.dart';
import 'package:deliverydigital/src/repositories/auth/auth_repository.dart';
import 'package:deliverydigital/src/repositories/auth/auth_repository_impl.dart';
import 'package:deliverydigital/src/services/auth/login_service.dart';
import 'package:deliverydigital/src/services/auth/login_service_impl.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImpl(i())),
        Bind.lazySingleton<LoginService>((i) => LoginServiceImpl(i(), i())),
        Bind.lazySingleton((i) => LoginController(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/:name',
            child: (context, args) => LoginPage(
                  name: args.params != null
                      ? args.params['name'].toString()
                      : null,
                )),
      ];
}
