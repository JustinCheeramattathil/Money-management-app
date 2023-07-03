import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gowallet/Screens/home/widgets/rootpage.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transactions/transaction_db.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../add_transaction/add_transaction.dart';
import 'transactionlistview.dart';

class Screen_Transaction extends StatefulWidget {
  const Screen_Transaction({super.key});

  @override
  State<Screen_Transaction> createState() => _Screen_TransactionState();
}

class _Screen_TransactionState extends State<Screen_Transaction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  dynamic dropDownVale = 'All';
  @override
  void initState() {
    dropDownVale = 'All';
    results.value.clear();
    results.notifyListeners();
    results.value = TransactionDB().transationAll.value;
    results.notifyListeners();
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      results.value = TransactionDB().transationAll.value;
      results.notifyListeners();
      setState(() {
        filter(dropDownVale);
      });
      results.notifyListeners();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime selectedmonth = DateTime.now();
  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary:
                    Color.fromARGB(213, 20, 27, 38), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color.fromARGB(213, 20, 27, 38), // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedmonth,
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));

    if (picked != null && picked != selectedmonth) {
      setState(() {
        selectedmonth = picked;
      });
    }
  }

  ValueNotifier<List<TransactionModel>> results = ValueNotifier([]);

  List items = ['All', 'today', 'yesterday', 'week', 'month'];

  String parseDate(DateTime date) {
    return DateFormat.MMMd().format(date);
  }

  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        filter(dropDownVale);
      });
    } else {
      setState(() {
        results.value = results.value
            .where((user) => user.category.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
        results.notifyListeners();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // results.clear();
    TransactionDB.instance.refreshAll();
    CategoryDB.instance.refreshUI();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: Text(
            'Transactions',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                RootPage.selectedIndexNotifier.value = 0;
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTransaction()));
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wall1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transationAll,
            builder: (context, value, child) => ValueListenableBuilder(
              valueListenable: results,
              builder: (context, value, child) => Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 250.0, right: 5),
                  child: DropdownButton(
                      icon: const Icon(
                        Icons.filter_list_alt,
                        color: Colors.teal,
                      ),
                      underline: Container(),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(10),
                      items: items.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(e),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue == 'month') {
                          _selectDate(context);
                        }
                        filter(newValue);
                      }),
                ),
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.teal,
                  tabs: const [
                    Tab(
                      text: 'Overview',
                    ),
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  TransationListView(
                    results: results.value,
                  ),
                  TransationListView(
                    results: results.value,
                  ),
                  TransationListView(
                    results: results.value,
                  )
                ])),
              ]),
            ),
          ),
        ));
  }

  void filter(newValue) {
    log('filter');

    results.value = TransactionDB().transationAll.value;
    results.notifyListeners();
    setState(() {
      dropDownVale = newValue;
    });
    log(results.value.length.toString(), name: 'vvvvvn');
    log(dropDownVale.toString(), name: 'filter');
    final DateTime now = DateTime.now();
    if (dropDownVale == 'All') {
      setState(() {
        results.value = (_tabController.index == 0
            ? TransactionDB().transationAll.value
            : _tabController.index == 1
                ? TransactionDB().incomeListenable.value
                : TransactionDB().expenseListenable.value);
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'today') {
      results.value.clear();
      setState(() {
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) => parseDate(element.date)
                .toLowerCase()
                .contains(parseDate(DateTime.now()).toLowerCase()))
            .toList();
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'yesterday') {
      results.value.clear();
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 1);
        DateTime end = start.add(const Duration(days: 1));
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
      results.notifyListeners();
      log(_tabController.index.toString(), name: 'filter_tabe');
    } else if (dropDownVale == 'week') {
      results.value.clear();
      results.notifyListeners();
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 6);
        DateTime end = DateTime(start.year, start.month, start.day + 7);
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
    } else {
      results.value.clear();
      setState(() {
        DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
        DateTime end = DateTime(start.year, start.month + 1, start.day);
        results.value = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
        results.notifyListeners();
      });
    }
  }
}
