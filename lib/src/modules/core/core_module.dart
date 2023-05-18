import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/core/rest_client/custom_dio.dart';
import 'package:deliverydigital/src/core/storage/session_storage.dart';
import 'package:deliverydigital/src/core/storage/storage.dart';
import 'package:deliverydigital/src/repositories/payment_type/payment_type_repository.dart';
import 'package:deliverydigital/src/repositories/payment_type/payment_type_repository_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton((i) => CustomDio(i()), export: true),
        Bind.lazySingleton<PaymentTypeRepository>(
            (i) => PaymentTypeRepositoryImpl(i()),
            export: true),
      ];
}
