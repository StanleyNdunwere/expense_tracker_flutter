import 'package:flutter/material.dart';

class ChartColumn extends StatelessWidget {
  String dayOfTheWeek;
  double percentageOfMax;
  double amount;

  ChartColumn(this.dayOfTheWeek, this.percentageOfMax, this.amount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.07,
              padding: EdgeInsets.all(0.03),
              child: FittedBox(
                child: Text(dayOfTheWeek.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Open Sans",
                      color: Colors.blue,
                    )),
              ),
            ),
            SizedBox(
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: Colors.teal,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    //                              color: Colors.teal,
                  ),
                  Container(
                    height: (percentageOfMax * 40),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(
                          color: Colors.teal,
                          width: 4,
                          style: BorderStyle.solid),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.06,
              padding: EdgeInsets.all(0.04),
              child: FittedBox(
                child: Text("\$${amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontFamily: "Open Sans",
                      color: Colors.blue,
                    )),
              ),
            ),
          ]);
    });
  }
}
