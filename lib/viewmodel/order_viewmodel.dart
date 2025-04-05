import 'package:flutter/material.dart';
import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/domain/order/usecase/get_orders_usecase.dart';
import 'package:sampleorder/domain/order/usecase/add_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/update_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/delete_order_usecase.dart';
import 'package:sampleorder/di/service_locator.dart';

class OrderViewModel extends ChangeNotifier {
  final GetOrdersUseCase _getOrdersUseCase = getIt<GetOrdersUseCase>();
  final AddOrderUseCase _addOrderUseCase = getIt<AddOrderUseCase>();
  final UpdateOrderUseCase _updateOrderUseCase = getIt<UpdateOrderUseCase>();
  final DeleteOrderUseCase _deleteOrderUseCase = getIt<DeleteOrderUseCase>();

  List<Order> orders = [];

  OrderViewModel() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    orders = await _getOrdersUseCase();
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    await _addOrderUseCase(order);
    await loadOrders();
  }

  Future<void> updateOrder(Order order) async {
    await _updateOrderUseCase(order);
    await loadOrders();
  }

  Future<void> deleteOrder(Order order) async {
    await _deleteOrderUseCase(order);
    await loadOrders();
  }
}
