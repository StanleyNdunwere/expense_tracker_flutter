import 'package:expense_tracker/widgets/charts.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
//  SystemChrome.setPreferredOrientations(setPreferredOrientations
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        buttonColor: Colors.teal,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 14,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "first day",
        amount: 200,
        date: DateTime.parse("2019-09-09")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "second day",
        amount: 300,
        date: DateTime.parse("2019-09-10")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "Third day",
        amount: 400,
        date: DateTime.parse("2019-09-11")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "fourth day",
        amount: 600,
        date: DateTime.parse("2019-09-13")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "fifth day",
        amount: 700,
        date: DateTime.parse("2019-09-14")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "sixth day",
        amount: 800,
        date: DateTime.parse("2019-09-15")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "seventh day",
        amount: 900,
        date: DateTime.parse("2019-09-16")),
    Transaction(
        id: DateTime.now().toIso8601String(),
        title: "first day",
        amount: 500,
        date: DateTime.parse("2019-09-12")),
  ];

  bool showCharts = false;

  void _addNewTransaction(
      {String title, double amount, DateTime date, String id}) {
    Transaction trans = Transaction(
        id: DateTime.now().toIso8601String(),
        amount: amount,
        date: date,
        title: title);
    setState(() {
      transactions.add(trans);
    });
  }

  void _removeTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  void addNewExpenses({BuildContext context, Builder builder}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            child: Expenses(_addNewTransaction),
            onTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscapeView =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appBar = AppBar(
      centerTitle: true,
      title: Text("Personal Expenses"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            addNewExpenses(context: context);
          },
        )
      ],
    );

    double availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: availableHeight * 0.1,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  "CHARTS",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            if (isLandscapeView)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Toggle Chart/List Display"),
                  Switch.adaptive(
                    value: showCharts,
                    onChanged: (val) {
                      setState(() {
                        showCharts = val;
                      });
                    },
                  ),
                ],
              ),
            if ((isLandscapeView && this.showCharts == true) ||
                !isLandscapeView)
              Container(
                  height: (isLandscapeView && this.showCharts == true)
                      ? availableHeight * 0.7
                      : availableHeight * 0.35,
                  child: Chart(transactions)),
            if ((isLandscapeView && this.showCharts == false) ||
                !isLandscapeView)
              Container(
                  height: (isLandscapeView && this.showCharts == false)
                      ? availableHeight * 0.7
                      : availableHeight * 0.59,
                  child: TransactionList(transactions, _removeTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addNewExpenses(context: context);
        },
      ),
    );
  }
}
