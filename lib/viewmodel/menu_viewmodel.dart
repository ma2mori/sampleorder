import 'package:flutter/material.dart';
import 'package:sampleorder/data/menu_repository.dart';
import 'package:sampleorder/domain/menu.dart';
import 'package:uuid/uuid.dart';

class MenuViewModel extends ChangeNotifier {
  final MenuRepository _repository = MenuRepository();
  List<MenuItem> menuItems = [];

  MenuViewModel() {
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    menuItems = await _repository.getMenuItems();
    notifyListeners();
  }

  Future<void> addMenuItem(String name, int price, String categoryId) async {
    final item = MenuItem(
      id: Uuid().v4(),
      name: name,
      price: price,
      categoryId: categoryId,
    );
    await _repository.addMenuItem(item);
    await _loadMenuItems();
  }

  Future<void> deleteMenuItem(String id) async {
    await _repository.deleteMenuItem(id);
    await _loadMenuItems();
  }
}
