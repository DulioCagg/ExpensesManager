import 'package:flutter/material.dart';

import '../total.dart';
import './expense_list.dart';
import './new_expense.dart';
import '../chart.dart';
import '../../models/card.dart';
import '../../models/expense.dart';

class ExpensesMenu extends StatefulWidget {
  final UserCard card;
  // final Function startAddNewExpense;
  // final Function removeExpense;

  ExpensesMenu(/*this.startAddNewExpense, this.removeExpense,*/ this.card);

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

  void addExpense(UserCard card, String newConcept, String newPlace,
      double newAmount, String newCategory) {
    final newExp = Expense(
        id: DateTime.now().toString(),
        concept: newConcept,
        place: newPlace,
        amount: newAmount,
        date: DateTime.now(),
        category: newCategory);
    setState(() {
      card.addExpense(newExp);
      card.updateExpenses();
    });
  }

  void removeExpenseTEST(String id, UserCard card) {
    setState(() {
      card.expenses.removeWhere((exp) => exp.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appbar = AppBar(
      title: Text("Expenses"),
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
                child: ExpenseList(widget.card, removeExpenseTEST)),
          ],
        ),
      ),
    );
  }
}
