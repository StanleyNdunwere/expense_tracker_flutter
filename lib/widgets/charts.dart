import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_column.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transList;
  List<Map<String, Object>> transactionSummary;
  double max = 0;
  static const WEEKDAY = "weekday";
  static const AMOUNT = "amount";

  Chart(this.transList) {
    transactionSummary = groupTransListByWeekday(transList);
    max = getMaximumTransactionValue(transactionSummary);
  }

  double getMaximumTransactionValue(List<Map> trans) {
    List<double> arrayOfAmounts = [];
    for (var map in trans) {
      arrayOfAmounts.add(double.parse((map[AMOUNT]).toString()));
    }
    double max = arrayOfAmounts
        .reduce((current, next) => (current > next) ? current : next);
    return max;
  }

  List<Map> groupTransListByWeekday(List<Transaction> transList) {
    List<Map<String, Object>> cumulativeDayAndAmountValues = [
      {WEEKDAY: "Mon", AMOUNT: 0},
      {WEEKDAY: "Tue", AMOUNT: 0},
      {WEEKDAY: "Wed", AMOUNT: 0},
      {WEEKDAY: "Thu", AMOUNT: 0},
      {WEEKDAY: "Fri", AMOUNT: 0},
      {WEEKDAY: "Sat", AMOUNT: 0},
      {WEEKDAY: "Sun", AMOUNT: 0},
    ];
    List<Map<String, Object>> singleDayAndAmountValues = [];
    for (var transaction in transList) {
      String transactionWeekDay =
          (DateFormat.E().format(transaction.date)).toString();
      double amount = (transaction.amount);
      singleDayAndAmountValues
          .add({WEEKDAY: transactionWeekDay, AMOUNT: amount});
    }

    for (var transRecord in singleDayAndAmountValues) {
      for (var cumulative in cumulativeDayAndAmountValues) {
        if (transRecord[WEEKDAY] == cumulative[WEEKDAY]) {
          cumulative[AMOUNT] = double.parse(cumulative[AMOUNT].toString()) +
              double.parse(transRecord[AMOUNT].toString());
        }
      }
    }
    print(cumulativeDayAndAmountValues.toString());
    return cumulativeDayAndAmountValues;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(8),
        child: (transList.isEmpty || transList == null)
            ? Container(
                padding: EdgeInsets.all(10),
                child: Text("Add an Expense and it'll show up here"),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ...transactionSummary.map((transaction) {
                    String dayOfTheWeek = transaction[WEEKDAY];
                    double amount =
                        double.parse(transaction[AMOUNT].toString());
                    double percentageOfMax =
                        double.parse((amount / max).toString());
                    return ChartColumn(dayOfTheWeek, percentageOfMax, amount);
                  }),
                ],
              ),
      ),
    );
  }
}
