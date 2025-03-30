import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 3)
class Transaction {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  final String voucherNumber;

  @HiveField(3)
  final int totalAmount;

  @HiveField(4)
  final int receivedAmount;

  @HiveField(5)
  final int change;

  // 注文された商品のIDと数量のマップ
  @HiveField(6)
  final Map<String, int> items;

  @HiveField(7)
  bool isDeleted;

  Transaction({
    required this.id,
    required this.dateTime,
    required this.voucherNumber,
    required this.totalAmount,
    required this.receivedAmount,
    required this.change,
    required this.items,
    this.isDeleted = false,
  });
}
