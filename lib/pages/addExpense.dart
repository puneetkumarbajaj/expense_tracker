import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';

class AddExpense extends WidgetWithTitle{
  const AddExpense({super.key}) : super(title: "Add Expense");

  @override
  Widget build(BuildContext context) {
    return const Text("Add");
  }
}