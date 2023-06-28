import 'package:flutter/material.dart';


import '../../../db/category/category_db.dart';
import '../../home/widgets/rootpage.dart';
import '../widget/category_add_popup.dart';
import '../widget/expense_category.dart';
import '../widget/income_category.dart';

class Screen_Category extends StatefulWidget {
  const Screen_Category({super.key});

  @override
  State<Screen_Category> createState() => _Screen_CategoryState();
}

class _Screen_CategoryState extends State<Screen_Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              RootPage.selectedIndexNotifier.value = 0;
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.yellow[300],
        title: Padding(
          padding: const EdgeInsets.only(left: 85),
          child: Text(
            'Categories',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[300],
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]),
        child: FloatingActionButton(
            onPressed: () => showCategoryAddPopup(context),
            child: Icon(Icons.add),
            backgroundColor: Colors.yellow,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17))),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15.0)),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs:const [
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    )
                  ]),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              IncomeCategory(),
              ExpenseCategory(),
            ],
          ))
        ],
      ),
    );
  }
}
