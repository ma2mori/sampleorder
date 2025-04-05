import 'package:sampleorder/domain/category/repository/category_repository.dart';
import 'package:sampleorder/domain/category/model/category.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<void> call(MenuCategory category) async {
    await repository.updateCategory(category);
  }
}
