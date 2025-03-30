import 'package:flutter/material.dart';
import 'package:sampleorder/data/order_repository.dart';
import 'package:sampleorder/domain/order.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository();
  List<Order> orders = [];

  OrderViewModel() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    orders = await _repository.getOrders();
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    await _repository.addOrder(order);
    await loadOrders();
  }

  Future<void> updateOrder(Order order) async {
    await _repository.updateOrder(order);
    await loadOrders();
  }

  Future<void> deleteOrder(String id) async {
    await _repository.deleteOrder(id);
    await loadOrders();
  }
}
