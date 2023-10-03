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
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Color.fromARGB(255, 20, 8, 5),
        title: Text(
          'Categories',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCategoryAddPopup(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 20, 8, 5),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.0)),
              child: TabBar(
                  indicator: BoxDecoration(
                      color: Color.fromARGB(255, 168, 144, 138),
                      borderRadius: BorderRadius.circular(15.0)),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Color.fromARGB(255, 168, 144, 138),
                  tabs: const [
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
