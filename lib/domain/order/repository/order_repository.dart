import 'package:sampleorder/domain/order/model/order.dart';

/// 注文に関するデータ永続化の抽象インターフェース
abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<void> addOrder(Order order);
  Future<void> updateOrder(Order order);
  Future<void> deleteOrder(Order order);
}
