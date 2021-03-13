import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personnal_expenses_app/widgets/chart.dart';
import 'package:personnal_expenses_app/widgets/new_transaction.dart';
import 'package:personnal_expenses_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  //Pour choisir le mode ( portrait ou autre )
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
  //    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dépenses personnel',
      theme: ThemeData(
        //PrimarySwatch est mieux que PrimaryColor et génére plusieurs nuances
        // d'une couleur
        primarySwatch: Colors.purple,
        //C'est à peu prés la couleur secondaire qqu'on mixe tjrs avec la princi
        //pale
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'PS4', amount: 340, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Laptop', amount: 197.95, date: DateTime.now()),
  ];

  bool _showCart = false;

  //Cette méthode est appelé chaque fois que le cycle de vie de l'application
  // change
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

  }

  List<Transaction> get _recentTransactions {
    //La méthode where est l'equivalent du for pour les listes
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //DateFormat.yMd('en_US').parse('1/10/2012');
    final appBar = AppBar(
      title: Text('Dépenses personnel'),
      //backgroundColor: Colors.red,
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show cart'),
                Switch(value: _showCart, onChanged: (val) {
                  setState(() {
                    _showCart = val;
                  });
                })
              ],
            ),*/
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
