import 'package:hive/hive.dart';
import 'package:sampleorder/domain/category/model/category.dart';
import 'package:sampleorder/domain/category/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Box _box = Hive.box('categories');

  @override
  Future<List<MenuCategory>> getCategories() async {
    return _box.values.cast<MenuCategory>().toList();
  }

  @override
  Future<void> addCategory(MenuCategory category) async {
    await _box.put(category.id, category);
  }

  @override
  Future<void> updateCategory(MenuCategory category) async {
    await _box.put(category.id, category);
  }

  @override
  Future<void> deleteCategory(MenuCategory category) async {
    await _box.delete(category.id);
  }
}
