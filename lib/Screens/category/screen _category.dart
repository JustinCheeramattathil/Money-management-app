import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import 'category_add_popup.dart';
import 'expense_category.dart';
import 'income_category.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCategoryAddPopup(context),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                )
              ]),
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
