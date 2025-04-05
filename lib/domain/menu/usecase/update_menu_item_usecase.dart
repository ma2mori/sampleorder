import 'package:sampleorder/domain/menu/repository/menu_repository.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';

class UpdateMenuItemUseCase {
  final MenuRepository repository;

  UpdateMenuItemUseCase(this.repository);

  Future<void> call(MenuItem item) async {
    await repository.updateMenuItem(item);
  }
}
