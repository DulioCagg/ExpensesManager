import 'package:flutter/material.dart';

import '../total.dart';
import './expense_list.dart';
import './new_expense.dart';
import '../chart.dart';
import '../../models/card.dart';
import '../../models/expense.dart';

// Describes the whole view of expenses
class ExpensesMenu extends StatefulWidget {
  // Initializes the view with the card and the function to update the database
  final UserCard card;
  final Function postInfoInDB;

  ExpensesMenu(this.card, this.postInfoInDB);

  @override
  _ExpensesMenuState createState() => _ExpensesMenuState();
}

class _ExpensesMenuState extends State<ExpensesMenu> {
  void startAddNewExpense(BuildContext ctx, UserCard card) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewExpense(addExpense, card);
      },
      isScrollControlled: true,
    );
  }

  // Function to add an expense to the expenses list of the card
  void addExpense(UserCard card, String newConcept, String newPlace,
      double newAmount, String newCategory) {
    final newExp = Expense(
        id: DateTime.now().toString(),
        concept: newConcept,
        place: newPlace,
        amount: newAmount,
        date: DateTime.now(),
        category: newCategory);

    // Updates the states to rerun the render method and shows the render
    setState(() {
      card.addExpense(newExp);
      card.updateExpenses();
    });
    // Saves the new information to the database
    widget.postInfoInDB();
  }

  // Removes an expense of the cards array and updates the database
  void removeExpense(String id, UserCard card) {
    setState(() {
      card.expenses.removeWhere((exp) => exp.id == id);
      card.updateExpenses();
      widget.postInfoInDB();
    });
  }

  // Describes the interface of the whole view
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appbar = AppBar(
      title: Text("Card: " + widget.card.number),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewExpense(context, this.widget.card),
        )
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.26,
                child: Chart(widget.card.expenses)),
            Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.099,
                child: Total(widget.card.total)),
            Container(
                height: (mediaQuery.size.height -
                        appbar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.64,
                child: ExpenseList(widget.card, removeExpense)),
          ],
        ),
      ),
    );
  }
}
