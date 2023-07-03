import 'package:flutter/material.dart';
import 'package:gowallet/Screens/home/widgets/rootpage.dart';
import 'package:gowallet/db/transactions/transaction_db.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Account/balance.dart';
import '../../chart_function/chart_function.dart';
import '../../graph/graphmodel.dart';

class Statistics_Screen extends StatefulWidget {
  const Statistics_Screen({Key? key}) : super(key: key);

  @override
  State<Statistics_Screen> createState() => _Statistics_ScreenState();
}

class _Statistics_ScreenState extends State<Statistics_Screen>
    with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseNotifier1.value);
  List<ChartDatas> dataIncome = chartLogic(incomeNotifier1.value);
  List<ChartDatas> overview = chartLogic(overviewNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    filterFunction();
    chartdivertFunctionExpense();
    chartdivertFunctionIncome();
    overviewNotifier.notifyListeners();
    incomeNotifier.notifyListeners();
    expenseNotifier.notifyListeners();
    todayNotifier.notifyListeners();
    yesterdayNotifier.notifyListeners();
    lastMonthNotifier.notifyListeners();
    lastWeekNotifier.notifyListeners();

    super.initState();
  }

  String categoryId2 = 'All';
  int touchIndex = 1;

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshAll();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Statistics',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              RootPage.selectedIndexNotifier.value = 0;
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
        child: ValueListenableBuilder(
          valueListenable: expenseNotifier,
          builder: (context, value, Widget? _) => Column(
            children: [
              SizedBox(
                height: height * 0.039,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: Material(
                  shadowColor: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                  elevation: 10,
                  child: Container(
                    height: height * 0.0657,
                    width: width * 0.83,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 12,
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: const Divider(
                          color: Colors.transparent,
                        ),
                        value: categoryId2,
                        items: <String>[
                          'All',
                          'Today',
                          'Yesterday',
                          'This week',
                          'month',
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryId2 = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.teal,
                ),
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.teal,
                tabs: const [
                  Tab(
                    text: 'Overview',
                  ),
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.0263,
              ),
              SizedBox(
                width: double.maxFinite,
                height: height * 0.526,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionOverview().isEmpty
                          ? Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Lottie.asset(
                                  'images/noresult.json',
                                  width: width * 0.9,
                                  height: height * 0.4,
                                ),
                              ),
                            )
                          : SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              series: <CircularSeries>[
                                PieSeries<ChartDatas, String>(
                                  dataLabelSettings: const DataLabelSettings(
                                    color: Colors.amberAccent,
                                    isVisible: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                    overflowMode: OverflowMode.shift,
                                    showZeroValue: false,
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                  ),
                                  dataSource: chartdivertFunctionOverview(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                )
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionIncome().isEmpty
                          ? Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Lottie.asset(
                                  'images/noresult.json',
                                  width: width * 0.9,
                                  height: height * 0.4,
                                ),
                              ),
                            )
                          : SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              series: <CircularSeries>[
                                PieSeries<ChartDatas, String>(
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                    overflowMode: OverflowMode.shift,
                                    showZeroValue: false,
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                  ),
                                  dataSource: chartdivertFunctionIncome(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                )
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionExpense().isEmpty
                          ? Center(
                              child: Container(
                                height: 150,
                                width: 150,
                                child: Lottie.asset(
                                  'images/noresult.json',
                                  width: width * 0.9,
                                  height: height * 0.4,
                                ),
                              ),
                            )
                          : SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              series: <CircularSeries>[
                                PieSeries<ChartDatas, String>(
                                  dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    connectorLineSettings:
                                        ConnectorLineSettings(
                                            type: ConnectorType.curve),
                                    overflowMode: OverflowMode.shift,
                                    showZeroValue: false,
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                  ),
                                  dataSource: chartdivertFunctionExpense(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
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
    );
  }

  chartdivertFunctionOverview() {
    if (categoryId2 == 'All') {
      return overview;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'month') {
      return month;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'month') {
      return expensemonth;
    }
  }
}
