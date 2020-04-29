import 'package:expense_app/models/card.dart';
import 'package:flutter/material.dart';

// Describes the form to add a new expense
class NewExpense extends StatefulWidget {
  final Function addExpense;
  final UserCard card;

  NewExpense(this.addExpense, this.card);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Initializes all the camps of the form
  final List<String> _categories = ["Fun", "Personal", "Professional"];
  final _conceptCon = TextEditingController();
  final _placeCon = TextEditingController();
  final _amountCon = TextEditingController();
  var _category = "Fun";

  // Checks if the form has any empty spaces, if its empty it doesnt allow to add the expense
  void onSubmit() {
    if (_conceptCon.text.isEmpty ||
        _placeCon.text.isEmpty ||
        double.parse(_amountCon.text) <= 0 ||
        _category == "") {
      return;
    }

    // Adds the expense to the card expenses carray
    widget.addExpense(widget.card, _conceptCon.text, _placeCon.text,
        double.parse(_amountCon.text) ?? 0, _category);

    Navigator.of(context).pop();
  }

  // Describes the interface of the form
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Concept"),
              controller: _conceptCon,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountCon,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Place"),
              controller: _placeCon,
            ),
            Expanded(
              child: ListWheelScrollView(
                onSelectedItemChanged: (index) {
                  _category = _categories[index];
                },
                itemExtent: 40,
                diameterRatio: 1,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                      child: Text(
                        "Fun",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                      child: Text(
                        "Personal",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                      child: Text(
                        "Professional",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: onSubmit,
              child: Text("Add Expense"),
              textColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
            )
          ],
        ),
      ),
    );
  }
}
