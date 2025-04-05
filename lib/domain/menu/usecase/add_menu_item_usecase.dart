import 'package:sampleorder/domain/menu/repository/menu_repository.dart';
import 'package:sampleorder/domain/menu/model/menu.dart';

class AddMenuItemUseCase {
  final MenuRepository repository;

  AddMenuItemUseCase(this.repository);

  Future<void> call(MenuItem item) async {
    await repository.addMenuItem(item);
  }
}
