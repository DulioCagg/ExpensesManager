import 'package:flutter/foundation.dart';

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
}
