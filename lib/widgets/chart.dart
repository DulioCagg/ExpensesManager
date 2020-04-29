import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import './chart_bar.dart';

// Describes the chart of the expenses by category
class Chart extends StatelessWidget {
  // Initializes the expenses array to show the graph
  final List<Expense> expenses;
  final List<String> categories = ["Fun", "Personal", "Professional"];

  Chart(this.expenses);

  // Getter to gruop the expenses based on their category
  List<Map<String, Object>> get groupedExpenses {
    return List.generate(3, (index) {
      var total = 0.0;

      // For each category, compare to all the expenses and compare if the expense corresponds to the category and  add to it
      if (expenses.length > 0) {
        for (var i = 0; i < expenses.length; i++) {
          if (expenses[i].category == categories[index]) {
            total += expenses[i].amount;
          }
        }
      }

      // Returns a map with the total amount for each category
      return {'category': categories[index], 'amount': total};
    });
  }

  // GGet the total amount of the card
  double get totalAmount {
    return groupedExpenses.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  // Describes the interface of the chart
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedExpenses.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data["category"],
                    data["amount"],
                    totalAmount == 0.0
                        ? 0.0
                        : (data["amount"] as double) / totalAmount),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
