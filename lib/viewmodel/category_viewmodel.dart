import 'package:flutter/material.dart';
import 'package:sampleorder/domain/category/model/category.dart';
import 'package:sampleorder/domain/category/usecase/get_categories_usecase.dart';
import 'package:sampleorder/domain/category/usecase/add_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/update_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/delete_category_usecase.dart';
import 'package:sampleorder/data/category/repository/category_repository_impl.dart';
import 'package:uuid/uuid.dart';

class CategoryViewModel extends ChangeNotifier {
  // ※ DI 導入前は簡易的に new で生成しています
  final GetCategoriesUseCase _getCategoriesUseCase =
      GetCategoriesUseCase(CategoryRepositoryImpl());
  final AddCategoryUseCase _addCategoryUseCase =
      AddCategoryUseCase(CategoryRepositoryImpl());
  final UpdateCategoryUseCase _updateCategoryUseCase =
      UpdateCategoryUseCase(CategoryRepositoryImpl());
  final DeleteCategoryUseCase _deleteCategoryUseCase =
      DeleteCategoryUseCase(CategoryRepositoryImpl());

  List<MenuCategory> categories = [];

  CategoryViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    categories = await _getCategoriesUseCase();
    notifyListeners();
  }

  Future<void> addCategory(String categoryName) async {
    final newCategory = MenuCategory(id: Uuid().v4(), name: categoryName);
    await _addCategoryUseCase(newCategory);
    await fetchCategories();
  }

  Future<void> editCategory(
      MenuCategory category, String newCategoryName) async {
    final updatedCategory =
        MenuCategory(id: category.id, name: newCategoryName);
    await _updateCategoryUseCase(updatedCategory);
    await fetchCategories();
  }

  Future<void> deleteCategory(MenuCategory category) async {
    await _deleteCategoryUseCase(category);
    await fetchCategories();
  }
}
