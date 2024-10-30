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

final List<Map<String, String>> fakeProducts = List.generate(
  10,
  (index) => {
    'name': 'Produto ${index + 1}',
    'description': 'Descrição do Produto ${index + 1}',
    'image': 'assets/images/fundo${index + 1}.png',
  },
);

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
      //statusDisposer = reaction((_) => controller.status, (status) async {
      //  switch (status) {
      //    case ProductStateStatus.initial:
      //      break;
      //    case ProductStateStatus.loading:
      //      showLoader();
      //      break;
      //    case ProductStateStatus.loaded:
      //      hideLoader();
      //      break;
      //    case ProductStateStatus.error:
      //      hideLoader();
      //      showError('Erro ao buscar produtos');
      //      break;
      //    case ProductStateStatus.addOrUpdateProduct:
      //      hideLoader();
      //      final productSelected = controller.productSelected;
//
      //      var uri = '/products/detail';
//
      //      if (productSelected != null) {
      //        uri += '?id=${productSelected.id}';
      //      }
//
      //      await Modular.to.pushNamed(uri);
      //      controller.loadProducts();
      //      break;
      //  }
      //});
      // controller.loadProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    // statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          BaseHeader(
            title: 'PRODUTOS',
            buttonLabel: 'ADICIONAR PRODUTO',
            buttonPressed: controller.addProduct,
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: fakeProducts.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 280,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: ((context, index) {
                    return ProductItem(product: fakeProducts[index]);
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Map<String, String> product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/fundo.png',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(product['name'] ?? 'Produto', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(product['description'] ?? 'Descrição do produto'),
        ],
      ),
    );
  }
}
