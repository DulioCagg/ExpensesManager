import 'package:flutter/foundation.dart';

// Describes the structure of the expenses
class Expense {
  final String id;
  final String concept;
  final String place;
  final double amount;
  final DateTime date;
  final String category;

  Expense(
      {@required this.id,
      @required this.concept,
      @required this.place,
      @required this.amount,
      @required this.date,
      @required this.category});

  // Method to transform the object into a json
  Map toJson() {
    Map exp = {
      "id": id,
      "concept": concept,
      "place": place,
      "amount": amount,
      "date": date.toString(),
      "category": category,
    };
    return exp;
  }
}
