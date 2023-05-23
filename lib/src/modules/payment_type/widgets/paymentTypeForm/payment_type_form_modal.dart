import 'package:flutter/material.dart';

import 'package:validatorless/validatorless.dart';

import 'package:deliverydigital/src/core/ui/helpers/size_extensions.dart';
import 'package:deliverydigital/src/core/ui/styles/text_styles.dart';
import 'package:deliverydigital/src/models/payment_type_model.dart';
import 'package:deliverydigital/src/modules/payment_type/payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel? model;
  const PaymentTypeFormModal(
      {super.key, required this.model, required this.controller});

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enabled = false;

  void _closeModal() => Navigator.of(context).pop();

  @override
  void initState() {
    final paymentModel = widget.model;
    if (paymentModel != null) {
      nameEC.text = paymentModel.name;
      acronymEC.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Text(
                      '${widget.model == null ? 'Adicionar' : 'Editar'} forma de pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: _closeModal,
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: acronymEC,
                  validator: Validatorless.required('Sigla obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Sigla'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Ativo:',
                    ),
                    Switch(
                        value: enabled,
                        onChanged: (value) {
                          setState(() {
                            enabled = value;
                          });
                        })
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(8),
                      child: OutlinedButton(
                        onPressed: _closeModal,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Text(
                          'Cancelar',
                          style: context.textStyles.textExtraBold
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            final name = nameEC.text;
                            final acronym = acronymEC.text;
                            widget.controller.savePayment(
                              id: widget.model?.id,
                              name: name,
                              acronym: acronym,
                              enabled: enabled,
                            );
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: Text(
                          'Salvar',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
