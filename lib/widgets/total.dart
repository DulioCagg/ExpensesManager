import 'package:flutter/material.dart';

// Describes the total shown of either a card or an expense
class Total extends StatelessWidget {
  final double total;

  Total(this.total);

  // Describes the interface of the total
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          child: Text(
            'Total spend: $total',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
