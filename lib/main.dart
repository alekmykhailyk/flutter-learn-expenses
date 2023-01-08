import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/transaction_add.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = //[];
      //=
      [
    Transaction(
      id: '1',
      title: 'Pineapple',
      amount: 9.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '2',
      title: 'Apple',
      amount: 6.38,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: '3',
      title: 'Carrot',
      amount: 8.77,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: '4',
      title: 'Watermelon',
      amount: 18.29,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: '5',
      title: 'Melon',
      amount: 24.50,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _existingTrasactionDeleted(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _newTransactionAdded(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void startAddingNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionAdd(_newTransactionAdded);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          //style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => startAddingNewTransaction(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddingNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(_recentTransactions),
            _transactionView(),
          ],
        ),
      ),
    );
  }

  Widget _transactionView() {
    if (_transactions.isEmpty) {
      return _transactionsEmptyView();
    } else {
      return TransactionList(_transactions, _existingTrasactionDeleted);
    }
  }

  Widget _transactionsEmptyView() {
    return Container(
        height: 100,
        child: Image.asset(
          'assets/images/waiting.png',
          fit: BoxFit.cover,
        ));
  }
}
