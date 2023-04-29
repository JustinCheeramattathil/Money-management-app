import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../db/category/category_db.dart';
import '../../db/category/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/rootpage.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction({super.key, required this.model});
  final TransactionModel model;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _formkey = GlobalKey<FormState>();

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    _purposeTextEditingController.text = widget.model.purpose;
    _amountTextEditingController.text = widget.model.amount.toString();
    _selectedDate = widget.model.date;
    _selectedCategorytype = widget.model.type;
    _selectedCategoryModel = widget.model.category;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _purposeTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Description',
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
                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Colors.teal,
                        ),
                  ),
                  child: TextButton.icon(
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
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.teal,
                    ),
                    label: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : DateFormat("dd-MMMM-yyyy").format(_selectedDate!),
                      style: const TextStyle(color: Colors.teal),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: _selectedCategorytype,
                            activeColor: Colors.teal,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.income;
                                _categoryID = null;
                              });
                            }),
                        Text(
                          'Income',
                          style: TextStyle(color: Colors.teal),
                        ),
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
                            activeColor: Colors.teal,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.expense;
                                _categoryID = null;
                              });
                            }),
                        const Text(
                          'Expense',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ],
                ),
                DropdownButton<String>(
                  underline: Container(),
                  hint: const Text(
                    'Select Category',
                    style: TextStyle(color: Colors.teal),
                  ),
                  value: _categoryID,
                  items: (_selectedCategorytype == CategoryType.income
                          ? CategoryDB().incomeCategoryListListener
                          : CategoryDB().expenseCategoryListListener)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(
                        e.name,
                        style: TextStyle(color: Colors.teal),
                      ),
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
                      backgroundColor: Colors.teal,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      editTransaction();
                    },
                    child: const Text('Save'),
                  ),
                )
              ],
            ),
          )),
        ));
  }

  Future<void> editTransaction() async {
    final _purposeText = _purposeTextEditingController.text.trim();
    final _amountText = _amountTextEditingController.text.trim();
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

    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategoryModel!);

    await TransactionDB.instance.editTransaction(_model);

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => Screen_Transaction()));
    RootPage.selectedIndexNotifier.value = 1;
    Navigator.of(context).pop();
    TransactionDB.instance.refreshAll();
  }
}
