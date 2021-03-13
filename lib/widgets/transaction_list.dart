import 'package:flutter/material.dart';
import 'package:personnal_expenses_app/models/transaction.dart';
import 'package:personnal_expenses_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                "Pas de transactions ajoutés !!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
            },
          );
  }
}


