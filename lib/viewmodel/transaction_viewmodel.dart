import 'package:flutter/material.dart';
import 'package:sampleorder/domain/transaction/model/transaction.dart';
import 'package:sampleorder/domain/transaction/usecase/get_transactions_usecase.dart';
import 'package:sampleorder/domain/transaction/usecase/add_transaction_usecase.dart';
import 'package:sampleorder/domain/transaction/usecase/update_transaction_usecase.dart';
import 'package:sampleorder/di/service_locator.dart';

class TransactionViewModel extends ChangeNotifier {
  final GetTransactionsUseCase _getTransactionsUseCase =
      getIt<GetTransactionsUseCase>();
  final AddTransactionUseCase _addTransactionUseCase =
      getIt<AddTransactionUseCase>();
  final UpdateTransactionUseCase _updateTransactionUseCase =
      getIt<UpdateTransactionUseCase>();

  List<Transaction> transactions = [];

  TransactionViewModel() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    transactions = await _getTransactionsUseCase();
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _addTransactionUseCase(transaction);
    await loadTransactions();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _updateTransactionUseCase(transaction);
    await loadTransactions();
  }
}
