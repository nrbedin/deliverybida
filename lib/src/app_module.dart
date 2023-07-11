import 'dart:js';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/modules/core/core_module.dart';
import 'package:deliverydigital/src/modules/login/login_module.dart';
import 'package:deliverydigital/src/modules/order/order_module.dart';
import 'package:deliverydigital/src/modules/payment_type/payment_type_module.dart';
import 'package:deliverydigital/src/modules/products/home/products_module.dart';
import 'package:deliverydigital/src/modules/template/base_layout.dart';

import './modules/home/home_page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/login', module: LoginModule()),
        ChildRoute(
          '/',
          child: (context, args) => const BaseLayout(
            body: RouterOutlet(),
          ),
          transition: TransitionType.noTransition,
          children: [
            ModuleRoute(
              '/payment-types',
              module: PaymentTypeModule(),
            ),
            ModuleRoute(
              '/products',
              module: ProductsModule(),
            ),
            ModuleRoute(
              '/orders',
              module: OrderModule(),
            ),
          ],
        ),
      ];
}
