import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../db/category/category_db.dart';
import '../../../models/category/category_model.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final category = newlist[index];
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 168, 144, 138),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                          title: Text(category.name),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete'),
                                        content: Text(
                                            'Are you sure?Do you want to delete the item?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                CategoryDB.instance
                                                    .deleteCategory(
                                                        category.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok'))
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                IconlyBold.delete,
                                color: Colors.black,
                              ))),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newlist.length,
          );
        });
  }
}
