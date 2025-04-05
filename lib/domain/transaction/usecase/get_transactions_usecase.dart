import 'package:sampleorder/domain/transaction/model/transaction.dart';
import 'package:sampleorder/domain/transaction/repository/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<Transaction>> call() async {
    return await repository.getTransactions();
  }
}
