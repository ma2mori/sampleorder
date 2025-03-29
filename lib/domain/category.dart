import 'package:hive/hive.dart';

part 'category.g.dart'; // Hiveジェネレーター用（後でビルド必要）

@HiveType(typeId: 1)
class MenuCategory {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  MenuCategory({required this.id, required this.name});
}
