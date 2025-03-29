import 'package:hive/hive.dart';
import 'package:sampleorder/domain/menu.dart';

class MenuRepository {
  final Box _box = Hive.box('menuItems');

  Future<List<MenuItem>> getMenuItems() async {
    return _box.values.cast<MenuItem>().toList();
  }

  Future<void> addMenuItem(MenuItem item) async {
    await _box.put(item.id, item);
  }

  Future<void> deleteMenuItem(String id) async {
    await _box.delete(id);
  }
}
