import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../db/category/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 212, 240, 213),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                // decoration: const InputDecoration(hintText: 'Purpose'),
                // decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(width: 3, color: Colors.grey),
                //         borderRadius: BorderRadius.circular(20)),
                //     hintText: 'purpose'),
                // decoration: const InputDecoration(
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(60),
                //     ),
                //   ),
                //   label: Text(
                //     "purpose",
                //     style: TextStyle(color: Colors.grey),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 2, color: Colors.grey),
                //   ),
                // ),
                decoration: InputDecoration(
                  labelText: 'purpose',
                  hintText: 'purpose',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                // decoration: const InputDecoration(hintText: 'Amount'),
                // decoration: const InputDecoration(
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(60),
                //     ),
                //   ),
                //   label: Text(
                //     "amount",
                //     style: TextStyle(color: Colors.grey),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 2, color: Colors.grey),
                //   ),
                // ),
                decoration: InputDecoration(
                  labelText: 'amount',
                  hintText: 'amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );

                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDate.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategorytype = CategoryType.income;
                              _categoryID = null;
                            });
                          }),
                      Text('Income'),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategorytype,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategorytype = CategoryType.expense;
                              _categoryID = null;
                            });
                          }),
                      const Text('Expense'),
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      print(e.toString());
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
                onTap: () {
                  addTransaction();
                },
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {},
                child: const Text('Submit'),
              ))
            ],
          ),
        )));
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    // _selectedDate
    // _selectedCategorytype
    // _categoryID
    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategoryModel!);

    TransactionDB.instance.addTransaction(_model);
  }
}
