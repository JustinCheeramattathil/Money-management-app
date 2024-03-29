import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      String title;
      return SimpleDialog(
        title: Center(
          child: const Text(
            'Add Category',
            style: TextStyle(color: Colors.black),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameEditingController,
              decoration: InputDecoration(
                  hintText: 'Category Name', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(55.0),
            child: Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 168, 144, 138))),
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    final check = selectedCategoryNotifier.value ==
                            CategoryType.income
                        ? CategoryDB.instance.incomeCategoryListListener.value
                            .where((element) => element.name.contains(_name))
                        : CategoryDB.instance.expenseCategoryListListener.value
                            .where((element) => element.name.contains(_name));
                    log(check.toString());
                    if (check.isNotEmpty) {
                      return;
                    }
                    if (_name.isEmpty) {
                      return;
                    }

                    final _type = selectedCategoryNotifier.value;
                    final _Category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);

                    CategoryDB.instance.insertCategory(_Category);
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Add'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 168, 144, 138))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel))
              ],
            ),
          )
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  // CategoryType? _type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: selectedCategoryNotifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(
          title,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
