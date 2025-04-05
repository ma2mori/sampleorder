import 'package:sampleorder/domain/transaction/model/transaction.dart';
import 'package:sampleorder/domain/transaction/repository/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<void> call(Transaction transaction) async {
    await repository.addTransaction(transaction);
  }
}
