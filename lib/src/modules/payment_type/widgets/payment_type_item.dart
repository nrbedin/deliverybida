import 'package:flutter/material.dart';

import 'package:deliverydigital/src/core/ui/styles/colors_app.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';
import 'package:deliverydigital/src/models/payment_type_model.dart';
import 'package:deliverydigital/src/modules/payment_type/payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel payment;
  const PaymentTypeItem(
      {super.key, required this.payment, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorAll = payment.enabled ? Colors.black : Colors.grey;
    return Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/icons/payment_${payment.acronym}_icon.png',
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/icons/payment_notfound_icon.png',
                    color: colorAll,
                  );
                },
                color: colorAll,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        'Forma de Pagamento',
                        style: context.textStyles.textRegular
                            .copyWith(color: colorAll),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      child: Text(payment.name,
                          style: context.textStyles.textTitle
                              .copyWith(color: colorAll)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      controller.editPayment(payment);
                    },
                    child: Text(
                      'Editar',
                      style: context.textStyles.textMedium.copyWith(
                        color: payment.enabled
                            ? context.colors.secondary
                            : context.colors.primary,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
