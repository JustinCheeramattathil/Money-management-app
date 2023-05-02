import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transactio-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> accessTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifietr =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseListenable = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transationAll = ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }

  Future<void> refreshAll() async {
    final _list = await accessTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifietr.value.clear();
    transactionListNotifietr.value.addAll(_list);
    transactionListNotifietr.notifyListeners();
    incomeListenable.value.clear();
    expenseListenable.value.clear();
    transationAll.value.clear();
    await Future.forEach(transactionListNotifietr.value,
        (TransactionModel transation) {
      if (transation.category.type == CategoryType.income) {
        incomeListenable.value.add(transation);
        log(incomeListenable.value.length.toString());
      } else if (transation.category.type == CategoryType.expense) {
        expenseListenable.value.add(transation);
      }
      transationAll.value.add(transation);
    });
  }

  @override
  Future<List<TransactionModel>> accessTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refreshAll();
  }

  @override
  Future<void> editTransaction(TransactionModel model) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(model.id, model);
  }

  Future<void> search(String text) async {
    final TransactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    transactionListNotifietr.value.clear();
    transactionListNotifietr.value.addAll(TransactionDB.values
        .where((element) => element.purpose.contains(text)));
    transactionListNotifietr.notifyListeners();
  }
}
