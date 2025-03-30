import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 4)
class Order {
  @HiveField(0)
  String id;

  @HiveField(1)
  final String voucherNumber;

  @HiveField(2)
  final DateTime dateTime;

  // 注文アイテムのリスト
  @HiveField(3)
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.voucherNumber,
    required this.dateTime,
    required this.items,
  });
}

@HiveType(typeId: 5)
enum OrderItemStatus {
  @HiveField(0)
  pending, // 未調理

  @HiveField(1)
  prepared, // 調理済み

  @HiveField(2)
  delivered, // 提供済み
}

@HiveType(typeId: 6)
class OrderItem {
  @HiveField(0)
  final String menuItemId;

  @HiveField(1)
  final int quantity;

  @HiveField(2)
  OrderItemStatus status;

  OrderItem({
    required this.menuItemId,
    required this.quantity,
    this.status = OrderItemStatus.pending,
  });
}
