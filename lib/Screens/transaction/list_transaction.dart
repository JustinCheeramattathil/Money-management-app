import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../db/category/category_db.dart';
import '../../db/category/transactions/transaction_db.dart';
import '../../models/transaction/transaction_model.dart';
import '../add_transaction/add_transaction.dart';
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
    results.clear();
    results = TransactionDB().transationAll.value;
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      results.clear();
      setState(() {
        filter(dropDownVale);
      });
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

  List<TransactionModel> results = [];

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
        results = results
            .where((user) => user.category.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      });
    }

    // Refresh the UI
  }

  @override
  Widget build(BuildContext context) {
    // results.clear();
    TransactionDB.instance.refreshAll();
    CategoryDB.instance.refreshUI();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[300],
          elevation: 0,
          automaticallyImplyLeading: false,
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
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 250.0, right: 5),
            child: DropdownButton(
                icon: const Icon(Icons.filter_list_alt),
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
                color: Colors.yellow,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(5, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 15,
                    offset: Offset(-5, -5),
                  ),
                ]),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
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
              results: results,
            ),
            TransationListView(
              results: results,
            ),
            TransationListView(
              results: results,
            )
          ])),
          // Container(
          //   child: ValueListenableBuilder(
          //       valueListenable:
          //           TransactionDB.instance.transactionListNotifietr,
          //       builder: (BuildContext context, List<TransactionModel> newList,
          //           Widget? _) {
          //         return Column(
          //           children: [
          //             Expanded(
          //                 child: newList.isNotEmpty
          //                     ? ListView.separated(
          //                         padding: const EdgeInsets.all(10),
          //                         itemBuilder: (context, index) {
          //                           final _value = newList[index];
          //                           return GestureDetector(
          //                             onTap: () {
          //                               Navigator.push(
          //                                   context,
          //                                   MaterialPageRoute(
          //                                       builder: (context) =>
          //                                           View_Transaction(
          //                                             amount: _value.amount,
          //                                             category:
          //                                                 _value.category.name,
          //                                             description:
          //                                                 _value.purpose,
          //                                             date: _value.date,
          //                                           )));
          //                             },
          //                             child: Slidable(
          //                               startActionPane: ActionPane(
          //                                   motion: const StretchMotion(),
          //                                   children: [
          //                                     SlidableAction(
          //                                       borderRadius:
          //                                           BorderRadius.circular(30),
          //                                       padding: EdgeInsets.all(8),
          //                                       backgroundColor: Colors.yellow,
          //                                       foregroundColor: Colors.black,
          //                                       icon: IconlyLight.edit,
          //                                       label: 'Edit',
          //                                       onPressed: (context) {
          //                                         final model =
          //                                             TransactionModel(
          //                                                 purpose:
          //                                                     _value.purpose,
          //                                                 amount: _value.amount,
          //                                                 date: _value.date,
          //                                                 category:
          //                                                     _value.category,
          //                                                 type: _value.type);
          //                                         Navigator.push(
          //                                             context,
          //                                             MaterialPageRoute(
          //                                                 builder: (context) =>
          //                                                     EditTransaction(
          //                                                       model: model,
          //                                                     )));
          //                                       },
          //                                     ),
          //                                     SlidableAction(
          //                                         borderRadius:
          //                                             BorderRadius.circular(30),
          //                                         spacing: 8,
          //                                         backgroundColor:
          //                                             Colors.yellow,
          //                                         foregroundColor: Colors.black,
          //                                         icon: IconlyLight.delete,
          //                                         label: 'Delete',
          //                                         onPressed: (context) {
          //                                           _value;

          //                                           showDialog(
          //                                               context: context,
          //                                               builder: (BuildContext
          //                                                   context) {
          //                                                 return AlertDialog(
          //                                                   title:
          //                                                       Text('Delete'),
          //                                                   content: Text(
          //                                                       'Are you sure?Do you want to delete this transaction?'),
          //                                                   actions: [
          //                                                     TextButton(
          //                                                         onPressed:
          //                                                             () {
          //                                                           Navigator.of(
          //                                                                   context)
          //                                                               .pop();
          //                                                         },
          //                                                         child: Text(
          //                                                             'Cancel')),
          //                                                     TextButton(
          //                                                         onPressed:
          //                                                             () {
          //                                                           TransactionDB
          //                                                               .instance
          //                                                               .deleteTransaction(
          //                                                                   _value.id!);
          //                                                           Navigator.of(
          //                                                                   context)
          //                                                               .pop();
          //                                                         },
          //                                                         child: Text(
          //                                                             'Ok'))
          //                                                   ],
          //                                                 );
          //                                               });
          //                                         })
          //                                   ]),
          //                               child: Card(
          //                                 shape: RoundedRectangleBorder(
          //                                     borderRadius:
          //                                         BorderRadius.circular(20)),
          //                                 child: Container(
          //                                   decoration: BoxDecoration(
          //                                     borderRadius:
          //                                         BorderRadius.circular(20),
          //                                     color: _value.type ==
          //                                             CategoryType.income
          //                                         ? Colors.white
          //                                         : Colors.white,
          //                                   ),
          //                                   child: Container(
          //                                     decoration: BoxDecoration(
          //                                         gradient: LinearGradient(
          //                                             colors: [
          //                                               Colors.yellow,
          //                                               Colors.white
          //                                             ]),
          //                                         borderRadius:
          //                                             BorderRadius.circular(
          //                                                 20)),
          //                                     child: ListTile(
          //                                       shape: RoundedRectangleBorder(
          //                                           borderRadius:
          //                                               BorderRadius.circular(
          //                                                   20)),
          //                                       leading: Text(
          //                                         parseDate(_value.date),
          //                                         style: TextStyle(
          //                                             fontSize: 16,
          //                                             fontWeight:
          //                                                 FontWeight.w500,
          //                                             color: Colors.black),
          //                                       ),
          //                                       trailing: Column(
          //                                         children: [
          //                                           Text(
          //                                             ' ${_value.category.name}',
          //                                             style: TextStyle(
          //                                               fontSize: 15,
          //                                               fontWeight:
          //                                                   FontWeight.w500,
          //                                               color: _value.type ==
          //                                                       CategoryType
          //                                                           .income
          //                                                   ? Colors.green
          //                                                   : Colors.red,
          //                                             ),
          //                                           ),
          //                                           Text(
          //                                             "₹ ${_value.amount}",
          //                                             style: TextStyle(
          //                                               fontSize: 20,
          //                                               fontWeight:
          //                                                   FontWeight.w500,
          //                                               color: _value.type ==
          //                                                       CategoryType
          //                                                           .income
          //                                                   ? Colors.green
          //                                                   : Colors.red,
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                           );
          //                         },
          //                         separatorBuilder: (context, index) {
          //                           return SizedBox(
          //                             height: 10,
          //                           );
          //                         },
          //                         itemCount: newList.length,
          //                       )
          //                     : Center(
          //                         child: Container(
          //                             height: 150,
          //                             width: 150,
          //                             child:
          //                                 Lottie.asset('images/noresult.json')),
          //                       )),
          //           ],
          //         );
          //       }),
          // ),
        ]));
  }

  // String parseDate(DateTime date) {
  //   final _date = DateFormat.MMMd().format(date);
  //   final _splitedDate = _date.split(' ');
  //   return '${_splitedDate.last}\n${_splitedDate.first}';
  // }

  void filter(newValue) {
    results.clear();

    setState(() {
      dropDownVale = newValue;
    });
    final DateTime now = DateTime.now();
    if (dropDownVale == 'All') {
      results.clear();
      setState(() {
        results = (_tabController.index == 0
            ? TransactionDB().transactionListNotifietr.value
            : _tabController.index == 1
                ? TransactionDB().incomeListenable.value
                : TransactionDB().expenseListenable.value);
      });
    } else if (dropDownVale == 'today') {
      results.clear();
      setState(() {
        results = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) => parseDate(element.date)
                .toLowerCase()
                .contains(parseDate(DateTime.now()).toLowerCase()))
            .toList();
      });
    } else if (dropDownVale == 'yesterday') {
      results.clear();
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 1);
        DateTime end = start.add(const Duration(days: 1));
        results = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
      });
    } else if (dropDownVale == 'week') {
      results.clear();
      setState(() {
        DateTime start = DateTime(now.year, now.month, now.day - 6);
        DateTime end = DateTime(start.year, start.month, start.day + 7);
        results = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
      });
    } else {
      results.clear();
      setState(() {
        DateTime start = DateTime(selectedmonth.year, selectedmonth.month, 1);
        DateTime end = DateTime(start.year, start.month + 1, start.day);
        results = (_tabController.index == 0
                ? TransactionDB().transationAll.value
                : _tabController.index == 1
                    ? TransactionDB().incomeListenable.value
                    : TransactionDB().expenseListenable.value)
            .where((element) =>
                (element.date.isAfter(start) || element.date == start) &&
                element.date.isBefore(end))
            .toList();
      });
    }
  }
}
