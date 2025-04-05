import 'package:sampleorder/domain/category/repository/category_repository.dart';
import 'package:sampleorder/domain/category/model/category.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> call(MenuCategory category) async {
    await repository.addCategory(category);
  }
}
