import 'package:expense_app/utilities/category_class_utility.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ExpenseTrackerDataBase {
  List<Category> categories = [];
  List<dynamic> expenses = [];
  double sum = 0;

  final dataBox = Hive.box("expenseTrackerBox");

  void createInitialData() {
    categories = [
      Category(name: "Bills", color: Color.fromARGB(255, 255, 191, 0)),
      Category(name: "Take Out",color: Color.fromARGB(255, 0, 0, 255)),
      Category(name: "Rent", color: Color.fromARGB(255, 0, 255, 0)),
      Category(name: "Groceries", color: Color.fromARGB(255, 255, 155, 15))
    ];
    expenses = [
      [12.5, "weekly", DateTime(2023, 10, 20), "Note", categories[1].name, categories[1].color],
      [13.0, "none", DateTime(2023, 10, 19), "Note", categories[0].name, categories[0].color],
    ];
  }

  void loadData() async {
    final categoriesData = dataBox.get("CATEGORIES");
    categories = List<Category>.from(categoriesData);
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

  Future<void> updateSumValue(String key, double newValue) async {
    await dataBox.put(key, newValue);
  }

}
