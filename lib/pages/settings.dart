import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';

class Settings extends WidgetWithTitle{
  const Settings({super.key}) : super(title: "Settings");

  @override
  Widget build(BuildContext context) {
    return const Text("Settings");
  }
}