import 'package:hive/hive.dart';
import 'package:sampleorder/domain/transaction.dart';

class TransactionRepository {
  final Box _box = Hive.box('transactions');

  Future<List<Transaction>> getTransactions() async {
    return _box.values.cast<Transaction>().toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }
}
