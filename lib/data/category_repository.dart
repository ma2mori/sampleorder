import 'package:hive/hive.dart';
import 'package:sampleorder/domain/category.dart';

class CategoryRepository {
  final Box _box = Hive.box('categories');

  Future<List<MenuCategory>> getCategories() async {
    return _box.values.cast<MenuCategory>().toList();
  }

  Future<void> addCategory(MenuCategory category) async {
    await _box.put(category.id, category);
  }

  Future<void> deleteCategory(String id) async {
    await _box.delete(id);
  }
}
