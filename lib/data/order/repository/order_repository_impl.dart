import 'package:hive/hive.dart';
import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/domain/order/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final Box _box = Hive.box('orders');

  @override
  Future<List<Order>> getOrders() async {
    return _box.values.cast<Order>().toList();
  }

  @override
  Future<void> addOrder(Order order) async {
    await _box.put(order.id, order);
  }

  @override
  Future<void> updateOrder(Order order) async {
    await _box.put(order.id, order);
  }

  @override
  Future<void> deleteOrder(Order order) async {
    await _box.delete(order.id);
  }
}
