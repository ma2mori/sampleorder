import 'package:hive/hive.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';
import 'package:sampleorder/domain/menu/repository/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final Box _box = Hive.box('menuItems');

  @override
  Future<List<MenuItem>> getMenuItems() async {
    return _box.values.cast<MenuItem>().toList();
  }

  @override
  Future<void> addMenuItem(MenuItem item) async {
    await _box.put(item.id, item);
  }

  @override
  Future<void> updateMenuItem(MenuItem item) async {
    await _box.put(item.id, item);
  }

  @override
  Future<void> deleteMenuItem(MenuItem item) async {
    await _box.delete(item.id);
  }
}
