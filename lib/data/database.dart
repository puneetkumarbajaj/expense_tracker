import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ExpenseTrackerDataBase {
  List categories = [];
  List<dynamic> expenses = [];

  final dataBox = Hive.box("expenseTrackerBox");

  void createInitialData() {
    categories = [
      ["Bills", Color.fromARGB(255, 255, 191, 0)],
      ["Take Out", Color.fromARGB(255, 0, 0, 255)],
      ["Rent", Color.fromARGB(255, 0, 255, 0)],
      ["Groceries", Color.fromARGB(255, 255, 155, 15)]
    ];
    expenses = [
      [12.5, "weekly", "2023-10-20", "Note", categories[1]],
      [13.0, "none", "2023-10-19", "Note", categories[0]],
    ];
  }

  void loadData() {
    categories = dataBox.get("CATEGORIES");
  }

  Future<void> updateData() async {
    dataBox.put("CATEGORIES", categories);
  }

  void loadExpenseData() {
    expenses = dataBox.get("EXPENSES");
  }

  void addExpense(List<dynamic> newExpense) {
    expenses.add(newExpense);
  }

  Future<void> updateExpenseData() async {
    dataBox.put("EXPENSES", expenses);
  }
}
