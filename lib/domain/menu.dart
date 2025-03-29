import 'package:hive/hive.dart';

part 'menu.g.dart'; // Hiveジェネレーター用（後でビルド必要）

@HiveType(typeId: 2)
class MenuItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String categoryId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final int price;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryId,
  });
}
