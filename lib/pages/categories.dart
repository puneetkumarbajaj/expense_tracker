import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';

class Categories extends WidgetWithTitle{
  const Categories({super.key}) : super(title: "Categories");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Categories"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
    );
  }
}