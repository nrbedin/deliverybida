import 'dart:developer';

import 'package:mobx/mobx.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deliverydigital/src/models/payment_type_model.dart';
import 'package:deliverydigital/src/repositories/payment_type/payment_type_repository.dart';

part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  PaymentTypeControllerBase(
    this._paymentTypeRepository,
  );

  @action
  Future<void> loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(null);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as formas de pagamento', error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
      _errorMessage = 'Erro ao carregar as formas de pagamento';
    }
  }
}
