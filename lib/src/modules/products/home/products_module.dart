import 'package:flutter_modular/flutter_modular.dart';

import 'package:deliverydigital/src/modules/products/home/detail/product_detail_page.dart';
import 'package:deliverydigital/src/modules/products/home/products_controller.dart';
import 'package:deliverydigital/src/modules/products/home/products_page.dart';
import 'package:deliverydigital/src/repositories/products/product_repository_impl.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => ProductsController(
            i(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProductsPage()),
        ChildRoute(
          '/detail',
          child: (context, args) => const ProductDetailPage(
            productId: null,
          ),
        ),
      ];
}
