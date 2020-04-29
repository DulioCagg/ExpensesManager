import '../models/expense.dart';

// Describes the structure of the cards
class UserCard {
  double total;
  String number;
  String bank;
  double budget;
  String validThru;
  List<Expense> expenses;
  Expense test;

  UserCard(
      {String number,
      String bank,
      double budget,
      String validThru,
      double total,
      List<Expense> expenses}) {
    this.total = total;
    this.number = number;
    this.bank = bank;
    this.budget = budget;
    this.validThru = validThru;
    this.expenses = expenses;
  }

  // Method to transform the object into a json
  Map toJson() {
    List<Map> expensesL = this.expenses.map((exp) => exp.toJson()).toList();
    Map card = {
      "total": total,
      "number": number,
      "bank": bank,
      "budget": budget,
      "validThru": validThru,
      "expenses": expensesL,
    };
    return card;
  }

  // Method to add an expense to the array expense
  void addExpense(Expense exp) {
    this.expenses.add(exp);
  }

  // Method to remove expense from the array
  void removeCard(String id) {
    this.expenses.removeWhere((exp) => exp.id == id);
  }

  // Method to updates the total of the card
  void updateExpenses() {
    this.total = 0.0;
    if (this.expenses.length > 0) {
      for (var exp in this.expenses) {
        this.total += exp.amount;
      }
    }
  }
}
