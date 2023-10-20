import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ExpenseTrackerDataBase{

  List categories = [];

  final dataBox = Hive.box("expenseTrackerBox");

  void createInitialData() {
    categories = [
      ["Bills", Color.fromARGB(255,0,0,255)],
      ["Take Out", Color.fromARGB(255,0,255,0)],
    ];
    }
    void loadData() {
      categories = dataBox.get("CATEGORIES");
    }

    Future<void> updateData() async{
      dataBox.put("CATEGORIES", categories);
    }
}