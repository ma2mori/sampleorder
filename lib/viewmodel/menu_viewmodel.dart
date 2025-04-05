import 'package:flutter/material.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';
import 'package:sampleorder/domain/menu/usecase/get_menu_items_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/add_menu_item_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/update_menu_item_usecase.dart';
import 'package:sampleorder/domain/menu/usecase/delete_menu_item_usecase.dart';
import 'package:sampleorder/data/menu/repository/menu_repository_impl.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

class MenuViewModel extends ChangeNotifier {
  final GetMenuItemsUseCase _getMenuItemsUseCase =
      GetMenuItemsUseCase(MenuRepositoryImpl());
  final AddMenuItemUseCase _addMenuItemUseCase =
      AddMenuItemUseCase(MenuRepositoryImpl());
  final UpdateMenuItemUseCase _updateMenuItemUseCase =
      UpdateMenuItemUseCase(MenuRepositoryImpl());
  final DeleteMenuItemUseCase _deleteMenuItemUseCase =
      DeleteMenuItemUseCase(MenuRepositoryImpl());

  List<MenuItem> menuItems = [];

  MenuViewModel() {
    fetchMenuItems();
  }

  Future<void> fetchMenuItems() async {
    menuItems = await _getMenuItemsUseCase();
    notifyListeners();
  }

  Future<void> addMenuItem(String name, int price, String categoryId) async {
    final item = MenuItem(
      id: Uuid().v4(),
      name: name,
      price: price,
      categoryId: categoryId,
    );
    await _addMenuItemUseCase(item);
    await fetchMenuItems();
  }

  Future<void> updateMenuItem(MenuItem item) async {
    await _updateMenuItemUseCase(item);
    await fetchMenuItems();
  }

  Future<void> deleteMenuItem(String id) async {
    final item = menuItems.firstWhereOrNull((m) => m.id == id);
    if (item != null) {
      await _deleteMenuItemUseCase(item);
      await fetchMenuItems();
    }
  }

  MenuItem? getMenuItemByKey(int key) {
    return menuItems.firstWhereOrNull((item) => item.key == key);
  }

  MenuItem? getMenuItemById(String id) {
    return menuItems.firstWhereOrNull((item) => item.id == id);
  }
}
