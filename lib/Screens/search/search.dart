import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../transaction/edit_transaction/edit_transaction.dart';
import '../transaction/view_transaction/view_Transaction.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchText = '';
  List<String> _searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[300],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: Colors.yellowAccent),
                  onChanged: (purpose) {
                    TransactionDB.instance.search(purpose);
                  },
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable:
                    TransactionDB.instance.transactionListNotifietr,
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        final _value = newList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => View_Transaction(
                                          amount: _value.amount,
                                          category: _value.category.name,
                                          description: _value.purpose,
                                          date: _value.date,
                                        )));
                          },
                          child: Slidable(
                            startActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(30),
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
                                          type: _value.type,
                                          id: _value.id);
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
                                      borderRadius: BorderRadius.circular(30),
                                      spacing: 8,
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: Colors.black,
                                      icon: IconlyLight.delete,
                                      label: 'Delete',
                                      onPressed: (context) {
                                        _value;

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Delete'),
                                                content: Text(
                                                    'Are you sure?Do you want to delete this transaction?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        TransactionDB.instance
                                                            .deleteTransaction(
                                                                _value.id!);
                                                        Navigator.of(context)
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: _value.type == CategoryType.income
                                      ? Colors.white
                                      : Colors.white,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.yellow,
                                        Colors.white
                                      ]),
                                      borderRadius: BorderRadius.circular(20)),
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
                    ),
                  );
                }),
          ],
        ));
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
  }
}
