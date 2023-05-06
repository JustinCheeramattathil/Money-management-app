import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class View_Transaction extends StatelessWidget {
  double amount;
  String category;
  String description;
  DateTime date;

  View_Transaction(
      {super.key,
      required this.amount,
      required this.category,
      required this.description,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[300],
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(60),
                gradient:
                    LinearGradient(colors: [Colors.yellow, Colors.white])),
            child: Column(
              children: [
                Text('Details',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: Icon(
                      Icons.note_add,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      'Notes :${description}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: Icon(
                      Icons.currency_rupee,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      'Amount :${amount}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      'Date :${parseDate(date)}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      'Category :${category}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}${_splitedDate.first}';
  }
}
