import 'package:flutter/material.dart';

class View_Transaction extends StatefulWidget {
  const View_Transaction({super.key});

  @override
  State<View_Transaction> createState() => _View_TransactionState();
}

class _View_TransactionState extends State<View_Transaction> {
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
                      'Notes :Book ordering',
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
                      'Amount :2000',
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
                      'Date :23-04-2023',
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
                      'Category :Income',
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
}
