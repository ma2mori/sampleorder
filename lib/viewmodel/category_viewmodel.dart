import 'package:flutter/material.dart';
import 'package:sampleorder/domain/category/model/category.dart';
import 'package:sampleorder/domain/category/usecase/get_categories_usecase.dart';
import 'package:sampleorder/domain/category/usecase/add_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/update_category_usecase.dart';
import 'package:sampleorder/domain/category/usecase/delete_category_usecase.dart';
import 'package:sampleorder/di/service_locator.dart';
import 'package:uuid/uuid.dart';

class CategoryViewModel extends ChangeNotifier {
  final GetCategoriesUseCase _getCategoriesUseCase =
      getIt<GetCategoriesUseCase>();
  final AddCategoryUseCase _addCategoryUseCase = getIt<AddCategoryUseCase>();
  final UpdateCategoryUseCase _updateCategoryUseCase =
      getIt<UpdateCategoryUseCase>();
  final DeleteCategoryUseCase _deleteCategoryUseCase =
      getIt<DeleteCategoryUseCase>();

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
