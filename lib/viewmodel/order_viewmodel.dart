import 'package:flutter/material.dart';
import 'package:sampleorder/data/order/repository/order_repository_impl.dart';
import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/domain/order/usecase/get_orders_usecase.dart';
import 'package:sampleorder/domain/order/usecase/add_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/update_order_usecase.dart';
import 'package:sampleorder/domain/order/usecase/delete_order_usecase.dart';

class OrderViewModel extends ChangeNotifier {
  final GetOrdersUseCase _getOrdersUseCase =
      GetOrdersUseCase(OrderRepositoryImpl());
  final AddOrderUseCase _addOrderUseCase =
      AddOrderUseCase(OrderRepositoryImpl());
  final UpdateOrderUseCase _updateOrderUseCase =
      UpdateOrderUseCase(OrderRepositoryImpl());
  final DeleteOrderUseCase _deleteOrderUseCase =
      DeleteOrderUseCase(OrderRepositoryImpl());

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
