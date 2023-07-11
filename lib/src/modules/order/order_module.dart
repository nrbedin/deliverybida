import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/modules/order/order_controller.dart';
import 'package:deliverydigital/src/modules/order/order_page.dart';
import 'package:deliverydigital/src/repositories/order/order_repository.dart';
import 'package:deliverydigital/src/repositories/order/order_repository_impl.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<OrderRepository>(
          (i) => OrderRepositoryImpl(
            i(),
          ),
        ),
        Bind.lazySingleton(
          (i) => OrderController(
            i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => const OrderPage())];
}
