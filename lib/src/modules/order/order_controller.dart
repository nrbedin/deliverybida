import 'dart:developer';

import 'package:mobx/mobx.dart';

import 'package:deliverydigital/src/models/orders/order_model.dart';
import 'package:deliverydigital/src/models/orders/order_status.dart';
import 'package:deliverydigital/src/repositories/order/order_repository.dart';
part 'order_controller.g.dart';

enum OrderStateStatus {
  initial,
  loading,
  loaded,
  error,
  showDetailModal,
}

class OrderController = OrderControllerBase with _$OrderController;

abstract class OrderControllerBase with Store {
  final OrderRepository _orderRepository;

  @readonly
  var _status = OrderStateStatus.initial;

  late final DateTime _today;

  @readonly
  OrderStatus? _statusFilter;

  @readonly
  var _orders = <OrderModel>[];

  @readonly
  String? _errorMessage;

  OrderControllerBase(
    this._orderRepository,
  ) {
    final todayNow = DateTime.now();
    _today = DateTime(todayNow.year, todayNow.month, todayNow.day);
  }

  @action
  Future<void> findOrders() async {
    try {
      _status = OrderStateStatus.loading;
      _orders = await _orderRepository.findAllOrders(_today, _statusFilter);
      _status = OrderStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar pedidos do diaaaaaa', error: e, stackTrace: s);
      print(e);
      print(s);
      _status = OrderStateStatus.error;
      _errorMessage = 'Erro ao buscar pedidos do diaaaaaaa';
    }
  }

  @action
  Future<void> showDetailModal(OrderModel model) async {
    _status = OrderStateStatus.loading;
    await Future.delayed(Duration.zero);
    _status = OrderStateStatus.showDetailModal;
  }
}
