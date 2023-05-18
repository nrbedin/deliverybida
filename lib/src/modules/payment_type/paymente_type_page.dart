import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/modules/payment_type/payment_type_controller.dart';
import 'package:deliverydigital/src/modules/payment_type/widgets/payment_type_header.dart';
import 'package:deliverydigital/src/modules/payment_type/widgets/payment_type_item.dart';

class PaymenteTypePage extends StatefulWidget {
  const PaymenteTypePage({super.key});

  @override
  State<PaymenteTypePage> createState() => _PaymenteTypePageState();
}

class _PaymenteTypePageState extends State<PaymenteTypePage> {
  final controller = Modular.get<PaymentTypeController>();

  //final ReactionDisposer

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          const PaymentTypeHeader(),
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 120,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              maxCrossAxisExtent: 680,
            ),
            itemBuilder: ((context, index) {
              return const PaymentTypeItem();
            }),
          )),
        ],
      ),
    );
  }
}
