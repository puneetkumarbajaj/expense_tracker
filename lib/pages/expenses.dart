import 'package:expense_app/data/database.dart';
import 'package:expense_app/utilities/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class Expenses extends StatefulWidget {
  final String title;

  Expenses({Key? key, this.title = "Expenses"}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final _myBox = Hive.box('expenseTrackerBox');
  ExpenseTrackerDataBase db = ExpenseTrackerDataBase();

  @override
  void initState() {
    //if this is the first time ever opening the app, then have some default data
    if (_myBox.get("EXPENSES") == null) {
      db.createInitialData();
    } else {
      //there is some data
      db.loadExpenseData();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: db.Expenses.length,
            itemBuilder: (context, index) {
              return ExpenseDisplay(
                amount: db.Expenses[index][0],
                occurence: db.Expenses[index][1],
                date: db.Expenses[index][2],
                note: db.Expenses[index][3],
                category: db.Expenses[index][4],
              );
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                debugPrint("Refresh");
                db.loadData();
              });
            },
            child: Text("Refresh"))
      ],
    ));
  }
}
