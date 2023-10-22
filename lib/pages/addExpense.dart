import 'package:expense_app/data/database.dart';
import 'package:expense_app/utilities/category_class_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class AddExpense extends StatefulWidget {
  final String title;

  const AddExpense({Key? key, this.title = "Add Expense"}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense>
    with AutomaticKeepAliveClientMixin {
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
  int? _amount;
  Category? _selectedCategory;
  final _myBox = Hive.box('expenseTrackerBox');
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  late Color categoryColor;

  ExpenseTrackerDataBase db = ExpenseTrackerDataBase();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //if this is the first time ever opening the app, then have some default data
    if (_myBox.isEmpty) {
      db.createInitialData();
    } else {
      //there is some data
      db.loadData();
      db.loadExpenseData();
    }
    super.initState();
  }

  void saveExpense() async {
    setState(() {
      _amountController.clear();
      _noteController.clear();
    });
    db.expenses.add([
      _amount,
      _currentRecurrence,
      _selectedDate,
      _enteredNote,
      _selectedCategory!.name,
      _selectedCategory!.color,
    ]);
    await db.updateExpenseData();
    _enteredNote = "";
    _amount = 0;
    debugPrint(db.expenses.toString());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<String> recurrenceOptions = [
      "None",
      "Daily",
      "Monthly",
      "Weekly",
      "Yearly"
    ];

    return Center(
      child: Column(
        children: [
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
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      width: 100, // adjust the width as needed
                      child: TextField(
                        controller: _amountController,
                        onChanged: (value) {
                          setState(() {
                            if (value != '') {
                              _amount = int.parse(value);
                            }
                          });
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ], // allows only digits
                        decoration: InputDecoration(
                          hintText: "0.00",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Recurrence"),
                    trailing: DropdownButton<String>(
                      value: _currentRecurrence,
                      items: recurrenceOptions.map((String value) {
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
                    title: const Text("Date"),
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
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Text(
                        _selectedDate != null
                            ? "${_selectedDate?.toLocal()}".split(' ')[0]
                            : "Choose Date",
                        style: (const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Note"),
                    trailing: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      width: 150, // adjust as per your needs
                      child: TextField(
                        controller: _noteController,
                        onChanged: (value) {
                          setState(() {
                            _enteredNote = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Enter note",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Category'),
                    trailing: DropdownButton<String>(
                      value: _selectedCategory?.name,
                      items: db.categories.map((Category) {
                        return DropdownMenuItem<String>(
                          value: Category.name,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 15,
                                height: 15,
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Category.color, 
                                  shape: BoxShape.circle
                                ),
                              ),
                              Text(Category.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            categoryColor = db.categories.firstWhere((Category) => Category.name == newValue).color;
                            _selectedCategory = Category(name: newValue,color: categoryColor);
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: saveExpense,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(200, 50),
            ),
            child: const Text(
              "Save Expense",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
