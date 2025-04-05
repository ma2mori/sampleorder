import 'package:sampleorder/domain/menu/model/menu.dart';

/// メニューに関するデータ永続化の抽象インターフェース
abstract class MenuRepository {
  Future<List<MenuItem>> getMenuItems();
  Future<void> addMenuItem(MenuItem item);
  Future<void> updateMenuItem(MenuItem item);
  Future<void> deleteMenuItem(MenuItem item);
}
