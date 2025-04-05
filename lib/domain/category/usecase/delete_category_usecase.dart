import 'package:sampleorder/domain/category/repository/category_repository.dart';
import 'package:sampleorder/domain/category/model/category.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(MenuCategory category) async {
    await repository.deleteCategory(category);
  }
}
