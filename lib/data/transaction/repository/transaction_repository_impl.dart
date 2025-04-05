import 'package:hive/hive.dart';
import 'package:sampleorder/domain/transaction/model/transaction.dart';
import 'package:sampleorder/domain/transaction/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Box _box = Hive.box('transactions');

  @override
  Future<List<Transaction>> getTransactions() async {
    return _box.values.cast<Transaction>().toList();
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }

  @override
  Future<void> updateTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }
}
