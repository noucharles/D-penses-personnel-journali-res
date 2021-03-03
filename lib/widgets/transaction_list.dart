import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personnal_expenses_app/models/transaction.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'PS4', amount: 340, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Laptop', amount: 197.95, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: _transactions.map((tx) {
            return Card(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      '\$${tx.amount.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        )),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat.yMMMd().format(tx.date),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        )
    );
  }
}
