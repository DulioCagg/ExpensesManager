import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/card.dart';

// Describes the component that shows the expenses list
class ExpenseList extends StatelessWidget {
  // Initializes the card and the delete function
  final UserCard card;
  final Function deleteExpense;

  ExpenseList(this.card, this.deleteExpense);

  // Describes the interface of the expense list and pass the delete function to each component
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                    child: Text(
                        '\$${card.expenses[index].amount.toStringAsFixed(2)}')),
              ),
            ),
            title: Text(
              card.expenses[index].concept,
            ),
            subtitle: Text(
              '${card.expenses[index].place} - ${DateFormat.MMMd().format(card.expenses[index].date)}',
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteExpense(card.expenses[index].id, card)),
          ),
        );
      },
      itemCount: card.expenses.length,
    ));
  }
}
