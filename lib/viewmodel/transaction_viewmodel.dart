import 'package:flutter/material.dart';
import 'package:sampleorder/data/transaction_repository.dart';
import 'package:sampleorder/domain/transaction.dart';

class TransactionViewModel extends ChangeNotifier {
  final TransactionRepository _repository = TransactionRepository();
  List<Transaction> transactions = [];

  TransactionViewModel() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    transactions = await _repository.getTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _repository.addTransaction(transaction);
    await loadTransactions();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _repository.updateTransaction(transaction);
    await loadTransactions();
  }
}
