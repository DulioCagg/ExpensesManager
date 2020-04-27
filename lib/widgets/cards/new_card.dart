import 'package:flutter/material.dart';

class NewCard extends StatefulWidget {
  final Function addCard;

  NewCard(this.addCard);

  @override
  _NewCardState createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  final _numberCon = TextEditingController();
  final _bankCon = TextEditingController();
  final _budgetCon = TextEditingController();
  final _validThroCon = TextEditingController();

  void onSubmit() {
    if (_numberCon.text.isEmpty ||
        _bankCon.text.isEmpty ||
        double.parse(_budgetCon.text) <= 0 ||
        _validThroCon.text.isEmpty) {
      return;
    }

    widget.addCard(_numberCon.text, _bankCon.text,
        double.parse(_budgetCon.text) ?? 0, _validThroCon.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Card Number"),
              controller: _numberCon,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Budget"),
              controller: _budgetCon,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Bank"),
              controller: _bankCon,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Valid Thru"),
              controller: _validThroCon,
            ),
            FlatButton(
              onPressed: onSubmit,
              child: Text("Add Card"),
              textColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
            )
          ],
        ),
      ),
    );
  }
}
