import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/core/ui/helpers/debouncer.dart';
import 'package:deliverydigital/src/core/ui/helpers/loader.dart';
import 'package:deliverydigital/src/core/ui/helpers/messages.dart';
import 'package:deliverydigital/src/core/ui/widgets/base_header.dart';
import 'package:deliverydigital/src/modules/products/home/products_controller.dart';
import 'package:deliverydigital/src/modules/products/home/widgets/product_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Modular.get<ProductsController>();

  late final ReactionDisposer statusDisposer;
  final debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) async {
        switch (status) {
          case ProductStateStatus.initial:
            break;
          case ProductStateStatus.loading:
            showLoader();
            break;
          case ProductStateStatus.loaded:
            hideLoader();
            break;
          case ProductStateStatus.error:
            hideLoader();
            showError('Erro ao buscar produtos');
            break;
          case ProductStateStatus.addOrUpdateProduct:
            hideLoader();
            final productSelected = controller.productSelected;

            var uri = '/products/detail';

            if (productSelected != null) {
              uri += '?id=${productSelected.id}';
            }

            await Modular.to.pushNamed(uri);
            controller.loadProducts();
            break;
        }
      });
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(children: [
        BaseHeader(
          title: 'PRODUTOS',
          buttonLabel: 'ADICIONAR PRODUTO',
          buttonPressed: controller.addProduct,
        ),
        const SizedBox(
          height: 50,
        ),
        Expanded(child: Observer(builder: (_) {
          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 280,
              mainAxisSpacing: 20,
              maxCrossAxisExtent: 280,
              crossAxisSpacing: 10,
            ),
            itemBuilder: ((context, index) {
              return ProductItem(product: controller.products[index]);
            }),
          );
        })),
      ]),
    );
  }
}
