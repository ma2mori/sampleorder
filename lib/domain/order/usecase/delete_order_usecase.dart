import 'package:sampleorder/domain/order/model/order.dart';
import 'package:sampleorder/domain/order/repository/order_repository.dart';

class DeleteOrderUseCase {
  final OrderRepository repository;

  DeleteOrderUseCase(this.repository);

  Future<void> call(Order order) async {
    await repository.deleteOrder(order);
  }
}
