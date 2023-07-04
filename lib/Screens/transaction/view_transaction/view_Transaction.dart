import 'package:flutter/material.dart';
import 'package:gowallet/Screens/home/widgets/rootpage.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Transaction Details',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/wall1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.teal.withOpacity(0.6),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text('Details',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ListTile(
                      leading: Icon(
                        Icons.note_add,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        'Notes :${description}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ListTile(
                      leading: Icon(
                        Icons.currency_rupee,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        'Amount :${amount}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        'Date :${parseDate(date)}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ListTile(
                      leading: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        'Category :${category}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
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
