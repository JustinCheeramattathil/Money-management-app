import 'package:flutter/material.dart';
import 'package:gowallet/Screens/category/view/screen%20_category.dart';
import 'package:intl/intl.dart';

import '../../db/category/category_db.dart';
import '../../db/transactions/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';
import '../home/widgets/rootpage.dart';

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

  final _formkey = GlobalKey<FormState>();

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    CategoryDB.instance.refreshUI();
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: Text(
            'New Transaction',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                RootPage.selectedIndexNotifier.value = 0;
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wall1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _purposeTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      fillColor: Colors.teal,
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _amountTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      labelText: 'amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Colors.black,
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
                      color: Colors.black,
                    ),
                    label: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : DateFormat("dd-MMMM-yyyy").format(_selectedDate!),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: Column(
                          children: [
                            Radio(
                                value: CategoryType.income,
                                groupValue: _selectedCategorytype,
                                activeColor: Colors.black,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategorytype = CategoryType.income;
                                    _categoryID = null;
                                  });
                                }),
                            Text(
                              'Income',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal,
                        ),
                        child: Column(
                          children: [
                            Radio(
                                value: CategoryType.expense,
                                groupValue: _selectedCategorytype,
                                activeColor: Colors.black,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategorytype =
                                        CategoryType.expense;
                                    _categoryID = null;
                                  });
                                }),
                            const Text(
                              'Expense',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              Text("Add Category"),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Screen_Category(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: DropdownButton<String>(
                            underline: Container(),
                            hint: const Text(
                              'Select Category',
                              style: TextStyle(color: Colors.black),
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
                                  style: TextStyle(color: Colors.black),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal,
                      fixedSize: Size(200, 60),
                    ),
                    onPressed: () {
                      addTransaction();

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }

  Future<void> addTransaction() async {
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
        category: _selectedCategoryModel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    await TransactionDB.instance.addTransaction(_model);
    RootPage.selectedIndexNotifier.value = 1;
    TransactionDB.instance.refreshAll();
  }
}
