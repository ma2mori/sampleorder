import 'package:flutter/material.dart';
import 'package:sampleorder/data/category_repository.dart';
import 'package:sampleorder/domain/category.dart';
import 'package:uuid/uuid.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  List<MenuCategory> categories = [];

  CategoryViewModel() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    categories = await _repository.getCategories();
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    final category = MenuCategory(id: Uuid().v4(), name: name);
    await _repository.addCategory(category);
    await _loadCategories();
  }

  Future<void> deleteCategory(String id) async {
    await _repository.deleteCategory(id);
    await _loadCategories();
  }
}
