import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/domain/order/repository/order_repository.dart';

class AddOrderUseCase {
  final OrderRepository repository;

  AddOrderUseCase(this.repository);

  Future<void> call(Order order) async {
    await repository.addOrder(order);
  }
}
