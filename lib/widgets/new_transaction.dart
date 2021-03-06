import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount<=0) {
      return;
    }

    widget.addNewTransaction(
        enteredTitle, enteredAmount);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                decoration: InputDecoration(labelText: 'Titre'),
                controller: titleController,
                onSubmitted: (_val) => submitData
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Montant'),
              controller: amountController,
              keyboardType: TextInputType.number,
              //le _val est une convention. Je mets quelques choses que je vais
              // pas utiliser
              onSubmitted: (_val) => submitData,
            ),
            FlatButton(
              // () => submitData ou submitData
              onPressed: submitData,
              child: Text("Ajout d'une transacton"),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
