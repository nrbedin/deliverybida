import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/extensions/formatter_extensions.dart';
import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';
import 'package:deliverydigital/src/modules/order/detail/widgets/order_bottom_bar.dart';
import 'package:deliverydigital/src/modules/order/detail/widgets/order_info_tile.dart';
import 'package:deliverydigital/src/modules/order/detail/widgets/order_product_item.dart';

class OrderDetailModal extends StatefulWidget {
  const OrderDetailModal({super.key});

  @override
  State<OrderDetailModal> createState() => _OrderDetailModalState();
}

class _OrderDetailModalState extends State<OrderDetailModal> {
  void _closeModal() {
    Navigator.pop(context);
  }
  //void _closeModal() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Material(
      color: Colors.black26,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Detalhe do Pedido',
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: _closeModal,
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Nome do Cliente:',
                      style: context.textStyles.textBold,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Naiara Rafaela',
                      style: context.textStyles.textRegular,
                    )
                  ],
                ),
                const Divider(),
                ...List.generate(3, (index) => index)
                    .map((e) => const OrderProductItem())
                    .toList(),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido',
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        200.0.currencyPTBR,
                        style: context.textStyles.textExtraBold
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Endereço de entrega:',
                  info: 'Avenida Paulista, 200',
                ),
                const Divider(),
                const OrderInfoTile(
                  label: 'Forma de Pagamento',
                  info: 'Cartão de crédito',
                ),
                const SizedBox(
                  height: 10,
                ),
                const OrderBottomBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
