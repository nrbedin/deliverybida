import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/core/ui/helpers/loader.dart';
import 'package:deliverydigital/src/core/ui/helpers/messages.dart';
import 'package:deliverydigital/src/modules/payment_type/payment_type_controller.dart';
import 'package:deliverydigital/src/modules/payment_type/widgets/paymentTypeForm/payment_type_form_modal.dart';
import 'package:deliverydigital/src/modules/payment_type/widgets/payment_type_header.dart';
import 'package:deliverydigital/src/modules/payment_type/widgets/payment_type_item.dart';

final List<Map<String, String>> fakePaymentTypes = List.generate(
  5,
  (index) => {
    'id': 'Pagamento ${index + 1}',
    'description': 'Descrição do Pagamento ${index + 1}',
  },
);

class PaymenteTypePage extends StatefulWidget {
  const PaymenteTypePage({super.key});

  @override
  State<PaymenteTypePage> createState() => _PaymenteTypePageState();
}

class _PaymenteTypePageState extends State<PaymenteTypePage>
    with Loader, Messages {
  final controller = Modular.get<PaymentTypeController>();

  final disposers = <ReactionDisposer>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // final filterDisposer = reaction((_) => controller.filterEnabled, (_) {
      //   controller.loadPayments();
      // });
//
      // final status_Disposer = reaction((_) => controller.status, (status) {
      //   switch (status) {
      //     case PaymentTypeStateStatus.initial:
      //       break;
      //     case PaymentTypeStateStatus.loading:
      //       showLoader();
      //       break;
      //     case PaymentTypeStateStatus.loaded:
      //       hideLoader();
      //       break;
      //     case PaymentTypeStateStatus.error:
      //       hideLoader();
//
      //       showError(controller.errorMessage ??
      //           'Erro ao buscar formas de pagamentos');
      //       break;
      //     case PaymentTypeStateStatus.addOrUpdatePayment:
      //       hideLoader();
      //       showAddOrUpdatePayment();
      //       break;
      //     case PaymentTypeStateStatus.saved:
      //       hideLoader();
      //       Navigator.of(context, rootNavigator: true).pop();
      //       controller.loadPayments();
      //       break;
      //   }
      // });
      // disposers.addAll([status_Disposer, filterDisposer]);
      // controller.loadPayments();
    });
  }

  @override
  void dispose() {
    for (final dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  void showAddOrUpdatePayment() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: PaymentTypeFormModal(
              model: controller.paymentTypeSelected,
              controller: controller,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          PaymentTypeHeader(
              //  controller: controller,
              ),
          const SizedBox(
            height: 50,
          ),
          Expanded(child: Observer(builder: (_) {
            return GridView.builder(
              itemCount: fakePaymentTypes.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 120,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                maxCrossAxisExtent: 680,
              ),
              itemBuilder: ((context, index) {
                final paymentTypeModel = fakePaymentTypes[index];
                return PaymentTypeItem(
                  payment: paymentTypeModel,
                  //controller: controller,
                );
              }),
            );
          })),
        ],
      ),
    );
  }
}

class PaymentTypeItem extends StatelessWidget {
  final Map<String, String> payment;

  const PaymentTypeItem({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(payment['id'] ?? 'Pagamento'),
        subtitle: Text(payment['description'] ?? 'Descrição do pagamento'),
      ),
    );
  }
}

class PaymentTypeHeader extends StatelessWidget {
  const PaymentTypeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tipos de Pagamento',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        ElevatedButton(
          onPressed: () {
            // Ação fictícia
          },
          child: Text('ADICIONAR PAGAMENTO'),
        ),
      ],
    );
  }
}
