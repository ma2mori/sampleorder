import 'package:sampleorder/domain/menu/repository/menu_repository.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';

class DeleteMenuItemUseCase {
  final MenuRepository repository;

  DeleteMenuItemUseCase(this.repository);

  Future<void> call(MenuItem item) async {
    await repository.deleteMenuItem(item);
  }
}
