import 'package:flutter/material.dart';

import '../db/category/transactions/transaction_db.dart';
import '../models/category/category_model.dart';

ValueNotifier<double> incomeNotifier = ValueNotifier(0);
ValueNotifier<double> expenseNotifier = ValueNotifier(0);
ValueNotifier<double> totalNotifier = ValueNotifier(0);

Future<void> BalanceAmount() async {
  await TransactionDB.instance.accessTransactions().then((value) {
    expenseNotifier.value = 0;
    incomeNotifier.value = 0;
    totalNotifier.value = 0;

    for (var item in value) {
      if (item.type == CategoryType.income) {
        incomeNotifier.value += item.amount;
      } else {
        expenseNotifier.value += item.amount;
      }
    }
    totalNotifier.value = incomeNotifier.value - expenseNotifier.value;
  });

  print(incomeNotifier.value);
  print(expenseNotifier.value);
  print(totalNotifier.value);
}
