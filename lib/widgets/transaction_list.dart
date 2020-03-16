import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _transaction_list = [];
  Function _removeTrans;

  TransactionList(List<Transaction> transaction, Function removeTrans) {
    _transaction_list = transaction;
    this._removeTrans = removeTrans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: (_transaction_list.length == 0 || _transaction_list == null)
          ? LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.1,
                child: Text(
                  "Empty List",
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              Container(
                height: constraints.maxHeight * 0.7,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              )
            ],
          );
        },
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: FractionalOffset(0.5, 0.5),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "\$${_transaction_list[index].amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        )),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              _transaction_list[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              DateFormat.yMMMd().format(
                                  _transaction_list[index].date),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: FlatButton(
                        onPressed: () {
                          _removeTrans(index);
                        },
                        child: Stack(alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerRight,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              height: 4,
                              width: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
        itemCount: _transaction_list.length,
      ),
    );
  }
}
