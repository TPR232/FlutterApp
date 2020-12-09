import 'package:flutter/material.dart';
import 'package:scond_app/widgets/chart.dart';
import 'package:scond_app/widgets/new_transaction.dart';
import 'package:scond_app/widgets/transaction_list.dart';
import 'Models/transation.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenese',
      theme: ThemeData(primarySwatch: Colors.purple, buttonColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
    // Transation(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 23.99,
    //   date: DateTime.now(),
    // ),
    // Transation(
    //   id: 't2',
    //   title: 'weekly groceries',
    //   amount: 56.99,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chooseDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chooseDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _startaddNewTransaction(BuildContext cnt) {
    showModalBottomSheet(
      context: cnt,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal expenese'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startaddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_usertransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startaddNewTransaction(context),
      ),
    );
  }
}
