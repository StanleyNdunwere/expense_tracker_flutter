import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Expenses extends StatefulWidget {
  final Function addTrans;

  Expenses(this.addTrans);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime selectedDate;

  bool _validateContent({String title, String amount}) {
    if (title.isEmpty || amount.isEmpty) {
      return false;
    }
    try {
      double v = double.parse(amount);
      if (v is double) {
        return true;
      }
    } catch (Exception) {
      print("no idea what happened but here is the report : $Exception");
      return false;
    }
    return true;
  }

  void showDatePickerDialog({BuildContext context}) {
    showDatePicker(
      context: context,
      firstDate: DateTime.parse("2019-01-01"),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        date ?? DateTime.now();
        selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add Expenses:",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Expense Title",
                  hoverColor: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                decoration: InputDecoration(
                  labelText: "Amount",
                  hoverColor: Colors.blueAccent,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Text((selectedDate == null)
                          ? DateFormat.yMMMMEEEEd().format(DateTime.parse("2019-01-01"))
                          : DateFormat.yMMMMEEEEd().format(selectedDate))),
                  Expanded(
                    flex: 3,
                    child: RaisedButton(
                      onPressed: () {
                        showDatePickerDialog(context: this.context);
                        print(selectedDate);
                      },
                      elevation: 3,
                      color: Theme.of(context).primaryColor,
                      child: Text("Select Date"),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: OutlineButton(
                borderSide: BorderSide(color: Colors.blue),
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textColor: Colors.deepOrange,
                child: (Text(
                  "Add Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
                onPressed: () {
                  bool validateSuccessful = _validateContent(
                      title: titleController.text, amount: (amountController.text));
                  if (validateSuccessful) {
                    widget.addTrans(
                        title: titleController.text,
                        date: selectedDate,
                        amount: double.parse(amountController.text));
                  }
                  Navigator.of(context).pop();
                  print(dateController.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
