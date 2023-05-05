import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'Account/balance.dart';
import 'Screens/home/rootpage.dart';
import 'Screens/search/search.dart';
import 'Screens/transaction/edit_transaction.dart';
import 'Screens/transaction/view_Transaction.dart';
import 'db/category/transactions/transaction_db.dart';
import 'drawer/drawerpage.dart';
import 'models/category/category_model.dart';
import 'models/transaction/transaction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshAll();
    balanceAmount();
    var time = DateTime.now();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'GoWalleT',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.yellow[300],
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Search()));
                  },
                  icon: Icon(IconlyLight.search)),
            )
          ],
        ),
        drawer: DrawerPage(),
        backgroundColor: Colors.yellow[300],
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(60),
                gradient: LinearGradient(
                    colors: const [Colors.yellow, Colors.white, Colors.yellow]),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.030,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconlyLight.calendar),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            DateFormat("dd-MMMM-yyyy").format(time),
                            style:
                                TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    ValueListenableBuilder(
                        valueListenable: totalNotifier,
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Text(
                                totalNotifier.value.toString(),
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.transparent),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: incomeNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      incomeNotifier.value.toString(),
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          color: Colors.grey),
                                    );
                                  }),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: expenseNotifier,
                                      builder: (context, value, child) {
                                        return Text(
                                          expenseNotifier.value.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey),
                                        );
                                      }),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.transparent),
                                child: const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 0),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(width: 135),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.yellow),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    elevation: MaterialStateProperty.all<double>(10),
                  ),
                  onPressed: () {
                    RootPage.selectedIndexNotifier.value = 1;
                  },
                  child: Text('View All')),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifietr,
            builder: (BuildContext context, List<TransactionModel> newList,
                Widget? _) {
              return Expanded(
                  child: newList.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            final value = newList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => View_Transaction(
                                              amount: value.amount,
                                              category: value.category.name,
                                              description: value.purpose,
                                              date: value.date,
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
                                              purpose: value.purpose,
                                              amount: value.amount,
                                              date: value.date,
                                              category: value.category,
                                              type: value.type);
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
                                            value;

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
                                                          child:
                                                              Text('Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            TransactionDB
                                                                .instance
                                                                .deleteTransaction(
                                                                    value.id!);
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
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: value.type == CategoryType.income
                                          ? Colors.white
                                          : Colors.white,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: const [
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
                                          parseDate(value.date),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(
                                              ' ${value.category.name}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: value.type ==
                                                        CategoryType.income
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            ),
                                            Text(
                                              "₹ ${value.amount}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: value.type ==
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
                          child: SizedBox(
                              height: 130,
                              width: 130,
                              child: Lottie.asset('images/noresult.json')),
                        ));
            },
          ),
        ]),
      ),
    );
  }

  String parseDate(DateTime date) {
    final date0 = DateFormat.MMMd().format(date);
    final splitedDate = date0.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}
