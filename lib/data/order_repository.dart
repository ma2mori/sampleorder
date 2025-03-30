import 'package:hive/hive.dart';
import 'package:sampleorder/domain/order.dart';

class OrderRepository {
  final Box _box = Hive.box('orders');

  Future<List<Order>> getOrders() async {
    return _box.values.cast<Order>().toList();
  }

  Future<void> addOrder(Order order) async {
    await _box.put(order.id, order);
  }

  Future<void> updateOrder(Order order) async {
    await _box.put(order.id, order);
  }

  Future<void> deleteOrder(String id) async {
    await _box.delete(id);
  }
}
