import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                // gradient: LinearGradient(
                //     colors: [Color.fromARGB(176, 17, 151, 21), Colors.blue])
                color: Colors.teal.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                ),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            DateFormat("dd-MMMM-yyyy").format(time),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),

                          // SizedBox(
                          //   height: 400,
                          // ),
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: Colors.green),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: Colors.red),
                          // ),
                          Text(
                            'Justin',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Divider(
                          thickness: 2,
                          indent: 3,
                          endIndent: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Column(
                        children: const [
                          Text(
                            'Account Balance',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '₹10000.0',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SizedBox(
                            //   height: 400,
                            // ),
                            Container(
                              height: 80,
                              width: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(255, 255, 255, 0.302)),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.grey.shade300),
                                        child: const Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green, size: 40,

                                          ///,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: const [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Income",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "2000",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 80,
                              width: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white30),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: Colors.grey.shade300),
                                        child: const Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: const [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Expense",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "5000",
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.0)),
                child: TabBar(
                    indicator: BoxDecoration(
                        // gradient:
                        //     LinearGradient(colors: [Colors.green, Colors.blue]),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15.0)),
                    tabs: const [
                      Tab(
                        text: 'Month',
                      ),
                      Tab(
                        text: 'Week',
                      ),
                      Tab(
                        text: 'Day',
                      ),
                      // Tab(
                      //   text: 'chats',
                      // ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
