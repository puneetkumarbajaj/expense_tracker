import 'package:expense_app/pages/addExpense.dart';
import 'package:expense_app/pages/expenses.dart';
import 'package:expense_app/pages/reports.dart';
import 'package:expense_app/pages/settings.dart';
import 'package:flutter/material.dart';

class TabsController extends StatefulWidget{
  const TabsController({super.key});

  @override
  State<TabsController> createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController>{

  var _selectedIndex = 0;

  static const List<Widget> _pages = [
    Expenses(),
    Reports(),
    AddExpense(),
    Settings(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 4, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),
          backgroundColor: Colors.black,
          ),
      body: _pages[_selectedIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.paid),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
    ),
    )
    );
  }
}