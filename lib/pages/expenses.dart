import 'package:expense_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class Expenses  extends StatefulWidget {
  final String title;

  Expenses({Key? key, this.title = "Expenses"}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
   @override
  Widget build(BuildContext context) {
    return const Text("Expenses");
  }
}