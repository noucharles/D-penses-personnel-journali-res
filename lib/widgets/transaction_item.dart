import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personnal_expenses_app/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                  child: Text('\$${transaction.amount}'))),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
            (DateFormat.yMMMd().format(transaction.date))),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            deleteTransaction(transaction.id);
          },
        ),
      ),
    );
  }
}