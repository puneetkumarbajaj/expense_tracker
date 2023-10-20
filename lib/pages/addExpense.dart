import 'package:expense_app/data/database.dart';
import 'package:expense_app/pages/categories.dart';
import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class AddExpense extends StatefulWidget {
  final String title;

  AddExpense({Key? key, this.title = "Add Expense"}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final List<String> recurrence = [
    'None',
    'daily',
    'weekly',
    'monthly',
    'yearly'
  ];
  String _currentRecurrence = "None";
  ValueChanged<String?>? onCategorySelected;
  DateTime? _selectedDate;
  String _enteredNote = "";
  String? _selectedCategory;
  final _myBox = Hive.box('expenseTrackerBox');
  ExpenseTrackerDataBase db = ExpenseTrackerDataBase();

  @override
  void initState() {
    //if this is the first time ever opening the app, then have some default data
    if (_myBox.get("CATEGORIES") == null) {
      db.createInitialData();
    } else {
      //there is some data
      db.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _recurrenceOptions = [
      "None",
      "Daily",
      "Monthly",
      "Weekly",
      "Yearly"
    ];

    return Center(
        child: Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 320,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 28, 28, 30),
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text("Amount"),
                trailing: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 100, // adjust the width as needed
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ], // allows only digits
                    decoration: InputDecoration(
                      hintText: "0.00",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text("Recurrence"),
                trailing: DropdownButton<String>(
                  value: _currentRecurrence,
                  items: _recurrenceOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _currentRecurrence = newValue;
                      });
                    }
                  },
                ),
              ),
              ListTile(
                title: Text("Date"),
                trailing: TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime(2022), // Modify as per your requirement
                      lastDate:
                          DateTime(2024), // Modify as per your requirement
                    );
                    if (pickedDate != null && pickedDate != _selectedDate)
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                  },
                  child: Text(
                    _selectedDate != null
                        ? "${_selectedDate?.toLocal()}".split(' ')[0]
                        : "Choose Date",
                    style: (TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              ListTile(
                title: Text("Note"),
                trailing: Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 150, // adjust as per your needs
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _enteredNote = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter note",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Category'),
                trailing: DropdownButton<String>(
                  value: _selectedCategory,
                  items: db.categories.map((category) {
                    String value = category[0];
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      ElevatedButton(onPressed: (){},
       child: Text("Save Expense", style: TextStyle(color: Colors.white),),
       style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: Size(200, 50),
       ))
    ]));
  }
}
