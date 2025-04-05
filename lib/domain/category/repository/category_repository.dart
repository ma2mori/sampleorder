import 'package:sampleorder/domain/category/model/category.dart';

/// カテゴリーに関するデータ永続化の抽象インターフェース
abstract class CategoryRepository {
  Future<List<MenuCategory>> getCategories();
  Future<void> addCategory(MenuCategory category);
  Future<void> updateCategory(MenuCategory category);
  Future<void> deleteCategory(MenuCategory category);
}
