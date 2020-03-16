//import 'package:expense_tracker/models/transaction.dart';
//import 'package:expense_tracker/widgets/expenses.dart';
//import 'package:expense_tracker/widgets/transaction_list.dart';
//import 'package:flutter/material.dart';
//
//
//class UserTransactions extends StatefulWidget {
//  @override
//  _UserTransactionsState createState() => _UserTransactionsState();
//}
//
//class _UserTransactionsState extends State<UserTransactions> {
//  List<Transaction> transactions = [];
//
//  void _addNewTransaction(
//      {String title, double amount, DateTime date, String id}) {
//    Transaction trans = Transaction(
//        id: DateTime.now().toIso8601String(),
//        amount: amount,
//        date: DateTime.now(),
//        title: title);
//    setState(() {
//      transactions.add(trans);
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child:
//     Column(
//      children: <Widget>[
//        Expenses(_addNewTransaction),
//        TransactionList(transactions),
//      ],
//    ));
//  }
//}
