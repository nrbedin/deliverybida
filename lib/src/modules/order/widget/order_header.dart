import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/widgets/base_header.dart';
import 'package:deliverydigital/src/models/orders/order_status.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({super.key});

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  OrderStatus? statusSelected;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Pedidos',
      addButton: false,
      filterWidget: DropdownButton<OrderStatus?>(
        value: statusSelected,
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text('Todos'),
          ),
          ...OrderStatus.values
              .map(
                (s) => DropdownMenuItem(
                  value: s,
                  child: Text(s.name),
                ),
              )
              .toList()
        ],
        onChanged: (value) {
          setState(() {
            statusSelected = value;
          });
        },
      ),
    );
  }
}
