import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/core/ui/helpers/loader.dart';
import 'package:deliverydigital/src/core/ui/helpers/messages.dart';
import 'package:deliverydigital/src/modules/order/detail/order_detail_modal.dart';
import 'package:deliverydigital/src/modules/order/order_controller.dart';
import 'package:deliverydigital/src/modules/order/widget/order_header.dart';
import 'package:deliverydigital/src/modules/order/widget/order_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messages {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer statusDisposer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case OrderStateStatus.initial:
            break;
          case OrderStateStatus.loading:
            showLoader();
            break;
          case OrderStateStatus.loaded:
            hideLoader();
            break;
          case OrderStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro interno');
            break;
          case OrderStateStatus.showDetailModal:
            hideLoader();
            showOrderDetail();
            break;
        }
      });
      controller.findOrders();
    });
  }

  void showOrderDetail() {
    showDialog(
      context: context,
      builder: (context) {
        return const OrderDetailModal();
      },
    );
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                const OrderHeader(),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.orders.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 91,
                      maxCrossAxisExtent: 600,
                    ),
                    itemBuilder: (context, index) {
                      return OrderItem(order: controller.orders[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
