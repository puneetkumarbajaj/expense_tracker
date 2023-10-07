import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';

class Expenses extends WidgetWithTitle{
  const Expenses({super.key}) : super(title: "Expenses");

  @override
  Widget build(BuildContext context) {
    return const Text("Expenses");
  }
}