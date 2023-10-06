import 'package:flutter/material.dart';

class TabsController extends StatefulWidget{
  const TabsController({super.key});

  @override
  State<TabsController> createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController>{

  var _selectedIndex = 0;

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
          title: Text("Expenses $_selectedIndex"),
          backgroundColor: Colors.black,
          ),
      body: const Text("Hey"),
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