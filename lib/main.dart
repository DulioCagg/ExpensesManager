import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/expenses/new_expense.dart';
import 'widgets/expenses/expenses_menu.dart';
import 'models/expense.dart';
import 'widgets/cards/new_card.dart';
import 'models/card.dart';
import './widgets/total.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  var _totalCards = 0.0;
  static List<Expense> _expenses = [
    Expense(
        id: "0",
        concept: "New shoes",
        amount: 100,
        place: "Adidas.com",
        category: "Fun",
        date: DateTime.now()),
    Expense(
        id: "1",
        concept: "New game",
        amount: 200,
        place: "Steam",
        category: "Personal",
        date: DateTime.now()),
    Expense(
        id: "2",
        concept: "New Equipment",
        amount: 300,
        place: "Linio",
        category: "Professional",
        date: DateTime.now()),
  ];
  static List<Expense> _expensesTEST = [
    Expense(
        id: "0",
        concept: "New shoes",
        amount: 10,
        place: "Adidas.com",
        category: "Fun",
        date: DateTime.now()),
    Expense(
        id: "1",
        concept: "New game",
        amount: 20,
        place: "Steam",
        category: "Personal",
        date: DateTime.now()),
    Expense(
        id: "2",
        concept: "New Equipment",
        amount: 30,
        place: "Linio",
        category: "Professional",
        date: DateTime.now()),
  ];
  final List<UserCard> _cards = [
    UserCard(
        number: "0",
        bank: "Bancomer",
        total: 0,
        budget: 3000,
        validThru: "08/20",
        expenses: _expenses),
    UserCard(
        number: "1",
        bank: "Banamex",
        total: 0,
        budget: 1200,
        validThru: "09/20",
        expenses: _expensesTEST),
  ];

/////////////////////////////////////////////////////

  // void _addExpense(UserCard card, String newConcept, String newPlace,
  //     double newAmount, String newCategory) {
  //   final newExp = Expense(
  //       id: DateTime.now().toString(),
  //       concept: newConcept,
  //       place: newPlace,
  //       amount: newAmount,
  //       date: DateTime.now(),
  //       category: newCategory);
  //   setState(() {
  //     card.addExpense(newExp);
  //     _updateTotalCards();
  //   });
  // }

  // void _startAddNewExpense(BuildContext ctx, UserCard card) {
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (_) {
  //       return NewExpense(_addExpense, card);
  //     },
  //     isScrollControlled: true,
  //   );
  // }

/////////////////////////////////////////////////////

  // void _removeExpense(String id, String cardNumber) {
  //   print(cardNumber);
  //   setState(() {
  //     for (var card in _cards) {
  //       if (card.number == cardNumber) {
  //         card.expenses.removeWhere((exp) => exp.id == id);
  //       }
  //     }
  //   });
  // }

/////////////////////////////////////////////////////

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
  }

  void _startAddNewCard(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewCard(_addCard);
      },
      isScrollControlled: true,
    );
  }

/////////////////////////////////////////////////////

  void _selectCard(BuildContext ctx, int index) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => ExpensesMenu(
        /*_startAddNewExpense,  _removeExpense, */
        _cards[index])));
  }

  void _updateTotalCards() {
    var temp = 0.0;
    for (var card in _cards) {
      if (card.expenses.length == 0) continue;
      card.updateExpenses();
      temp += card.total;
    }
    setState(() {
      _totalCards = temp;
    });
  }

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
                height: 470,
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
                                    '\$${_cards[index].budget}',
                                    style: TextStyle(
                                        color: _cards[index].total <
                                                _cards[index].budget
                                            ? Colors.black87
                                            : Colors.red,
                                        fontSize: 13),
                                  ),
                                  Text(
                                    '\$${_cards[index].total}',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 11),
                                  ),
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
