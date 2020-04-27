import '../models/expense.dart';

class UserCard {
  double total;
  String number;
  String bank;
  double budget;
  String validThru;
  List<Expense> expenses;

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

  void addExpense(Expense exp) {
    this.expenses.add(exp);
  }

  void removeCard(String id) {
    this.expenses.removeWhere((exp) => exp.id == id);
  }

  void updateExpenses() {
    this.total = 0.0;
    if (this.expenses.length > 0) {
      for (var exp in this.expenses) {
        this.total += exp.amount;
      }
    }
  }
}
