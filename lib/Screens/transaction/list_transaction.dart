import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../db/category/category_db.dart';
import '../../db/category/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../add_transaction/add_transaction.dart';
import '../home/rootpage.dart';
import 'edit_transaction.dart';
import 'view_Transaction.dart';

class Screen_Transaction extends StatefulWidget {
  const Screen_Transaction({super.key});

  @override
  State<Screen_Transaction> createState() => _Screen_TransactionState();
}

class _Screen_TransactionState extends State<Screen_Transaction> {
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshAll();
    CategoryDB.instance.refreshUI();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[300],
        elevation: 0,
        leading: IconButton(
            onPressed: () => {RootPage.selectedIndexNotifier.value = 0},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          'Transactions',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow[300],
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 5),
          )
        ]),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTransaction()));
            },
            child: Icon(
              IconlyLight.plus,
              color: Colors.black,
            ),
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
      ),
      body: Container(
        child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifietr,
            builder: (BuildContext context, List<TransactionModel> newList,
                Widget? _) {
              return Column(
                children: [
                  Expanded(
                      child: newList.isNotEmpty
                          ? ListView.separated(
                              padding: const EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                final _value = newList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                View_Transaction()));
                                  },
                                  child: Slidable(
                                    startActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            padding: EdgeInsets.all(8),
                                            backgroundColor: Colors.yellow,
                                            foregroundColor: Colors.black,
                                            icon: IconlyLight.edit,
                                            label: 'Edit',
                                            onPressed: (context) {
                                              final model = TransactionModel(
                                                  purpose: _value.purpose,
                                                  amount: _value.amount,
                                                  date: _value.date,
                                                  category: _value.category,
                                                  type: _value.type);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditTransaction(
                                                            model: model,
                                                          )));
                                            },
                                          ),
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              spacing: 8,
                                              backgroundColor: Colors.yellow,
                                              foregroundColor: Colors.black,
                                              icon: IconlyLight.delete,
                                              label: 'Delete',
                                              onPressed: (context) {
                                                _value;

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Delete'),
                                                        content: Text(
                                                            'Are you sure?Do you want to delete this transaction?'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  'Cancel')),
                                                          TextButton(
                                                              onPressed: () {
                                                                TransactionDB
                                                                    .instance
                                                                    .deleteTransaction(
                                                                        _value
                                                                            .id!);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text('Ok'))
                                                        ],
                                                      );
                                                    });
                                              })
                                        ]),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              _value.type == CategoryType.income
                                                  ? Colors.white
                                                  : Colors.white,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.yellow,
                                                Colors.white
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            leading: Text(
                                              parseDate(_value.date),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            trailing: Column(
                                              children: [
                                                Text(
                                                  ' ${_value.category.name}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: _value.type ==
                                                            CategoryType.income
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  "₹ ${_value.amount}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: _value.type ==
                                                            CategoryType.income
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: newList.length,
                            )
                          : Center(
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Lottie.asset('images/noresult.json')),
                            )),
                ],
              );
            }),
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
  }
}
