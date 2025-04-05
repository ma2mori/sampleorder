import 'package:sampleorder/domain/transaction/model/transaction.dart';

/// 取引に関するデータ永続化の抽象インターフェース
abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
}
