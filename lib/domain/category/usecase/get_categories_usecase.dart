import 'package:sampleorder/domain/category/repository/category_repository.dart';
import 'package:sampleorder/domain/category/model/category.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<MenuCategory>> call() async {
    return await repository.getCategories();
  }
}
