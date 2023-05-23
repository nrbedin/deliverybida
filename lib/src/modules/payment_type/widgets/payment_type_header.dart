import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/widgets/base_header.dart';
import 'package:deliverydigital/src/modules/payment_type/payment_type_controller.dart';

class PaymentTypeHeader extends StatefulWidget {
  final PaymentTypeController controller;
  const PaymentTypeHeader({super.key, required this.controller});

  @override
  State<PaymentTypeHeader> createState() => _PaymentTypeHeaderState();
}

class _PaymentTypeHeaderState extends State<PaymentTypeHeader> {
  bool? enabled;
  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'FORMAS DE PAGAMENTO',
      buttonLabel: 'ADICIONAR',
      buttonPressed: () {
        widget.controller.addPayment();
      },
      filterWidget: DropdownButton<bool?>(
        value: enabled,
        items: const [
          DropdownMenuItem(
            value: null,
            child: Text('Todos'),
          ),
          DropdownMenuItem(
            value: true,
            child: Text('Ativos'),
          ),
          DropdownMenuItem(
            value: false,
            child: Text('Inativos'),
          ),
        ],
        onChanged: (bool? value) {
          setState(() {
            enabled = value;
            widget.controller.changeFilter(value);
          });
        },
      ),
    );
  }
}
