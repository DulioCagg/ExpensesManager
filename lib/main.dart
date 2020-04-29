import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'widgets/expenses/expenses_menu.dart';
import 'models/expense.dart';
import 'widgets/cards/new_card.dart';
import 'models/card.dart';
import './widgets/total.dart';

// The main function of the application
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Determine all the metadata of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initializes the total of the cards and the array of cards
  var _totalCards = 0.0;
  final List<UserCard> _cards = [];

  // Uploads the information of the cards to the database
  void _postInfoInDB() {
    const url = "https://walletmanager-c9ff9.firebaseio.com/cards.json";
    try {
      http.put(
        url,
        body: json.encode({
          'cards': _cards,
        }),
      );
    } catch (error) {
      print(error);
    }
  }

  // Fetches the information of the database and updates the array and total
  // Build all the clases with the information of the databases.
  Future<void> getData() async {
    const url = "https://walletmanager-c9ff9.firebaseio.com/cards.json";
    try {
      final resp = await http.get(url);
      final data = json.decode(resp.body) as Map;
      for (var card in data["cards"]) {
        final expenses = <Expense>[];
        if (card["expenses"] != null) {
          for (var exp in card["expenses"]) {
            var ex = Expense(
              id: exp["id"],
              concept: exp["concept"],
              place: exp["place"],
              amount: exp["amount"],
              date: DateTime.parse(exp["date"]),
              category: exp["category"],
            );
            expenses.add(ex);
          }
        }
        var newCard = UserCard(
            number: card["number"],
            bank: card["bank"],
            budget: card["budget"],
            validThru: card["validThru"],
            total: card["total"],
            expenses: expenses);
        setState(() {
          _cards.add(newCard);
        });
      }
    } catch (err) {
      print(err);
    }
  }

  // Adds a card to the cards array
  void _addCard(
      String newNumber, String newBank, double newBudget, String newValid) {
    final exp = <Expense>[];
    final newCard = UserCard(
        total: 0.0,
        number: newNumber,
        bank: newBank,
        budget: newBudget,
        validThru: newValid,
        expenses: exp);
    setState(() {
      _cards.add(newCard);
    });
    _postInfoInDB();
  }

  // Presents the add card form to the user
  void _startAddNewCard(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewCard(_addCard);
      },
      isScrollControlled: true,
    );
  }

  // Performs the segue to the selected card to show the expenses
  void _selectCard(BuildContext ctx, int index) {
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (_) => ExpensesMenu(_cards[index], _postInfoInDB)));
  }

  // Updates the total of all the cards inside the array
  void _updateTotalCards() {
    var temp = 0.0;
    for (var card in _cards) {
      if (card.expenses.length == 0) {
        card.total = 0;
      }
      card.updateExpenses();
      temp += card.total;
    }
    setState(() {
      _totalCards = temp;
    });
  }

  // Initializes the state before is presented to the user
  @override
  void initState() {
    getData();
  }

  // Descirbes the interface of the page presented to the user
  @override
  Widget build(BuildContext context) {
    _updateTotalCards();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewCard(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Total(_totalCards),
            Container(
                height: 550,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () => _selectCard(context, index),
                      splashColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      child: Card(
                        elevation: 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${_cards[index].number}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Text(
                                    _cards[index].bank,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'T: \$${_cards[index].total}',
                                    style: TextStyle(
                                        color: _cards[index].total <
                                                _cards[index].budget
                                            ? Colors.black87
                                            : Colors.red,
                                        fontSize: 14),
                                  ),
                                  Text('B: \$${_cards[index].budget}',
                                      style: TextStyle(
                                        color: _cards[index].total <
                                                _cards[index].budget
                                            ? Colors.black87
                                            : Colors.red,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _cards.length,
                )),
          ],
        ),
      ),
    );
  }
}
