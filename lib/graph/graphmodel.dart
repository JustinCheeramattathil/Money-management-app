import 'dart:developer';

import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

class ChartDatas {
  String category;
  double amount;
  ChartDatas({required this.category, required this.amount});
}

chartLogic(List<TransactionModel> model) {
  double value;
  String categoryname;
  List<ChartDatas> newData = [];
  List visited = [];

  for (var i = 0; i < model.length; i++) {
    visited.add(0);
  }
  for (var i = 0; i < model.length; i++) {
    value = model[i].amount.toDouble();
    categoryname =
        model[i].category.type == CategoryType.income ? 'Income' : 'Expense';
    log(model[i].category.type.toString());
    for (var j = i + 1; j < model.length; j++) {
      if (model[i].category == model[j].category) {
        value += model[j].amount;
        visited[j] = -1;
        log(value.toString());
      }
    }
    if (visited[i] != -1) {
      newData.add(ChartDatas(amount: value, category: categoryname));
    }
  }
  return newData;
}
