import 'package:sampleorder/domain/menu/repository/menu_repository.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';

class GetMenuItemsUseCase {
  final MenuRepository repository;

  GetMenuItemsUseCase(this.repository);

  Future<List<MenuItem>> call() async {
    return await repository.getMenuItems();
  }
}
