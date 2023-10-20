import 'package:expense_app/data/database.dart';
import 'package:expense_app/tabs.dart';
import 'package:expense_app/types/widgets.dart';
import 'package:expense_app/utilities/category_tile.dart';
import 'package:expense_app/utilities/catergory_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final _myBox = Hive.box('expenseTrackerBox');
  ExpenseTrackerDataBase db = ExpenseTrackerDataBase();

  final _controller = TextEditingController();

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

  void deleteCategory(int index) {
    setState(() {
      db.categories.removeAt(index);
    });
    db.updateData();
  }

  void saveCategory(Color selectedColor) async {
    var _test = _controller.text;
    print('saving category with color: $_test');
    setState(() {
      int alpha = selectedColor.alpha;
      int red = selectedColor.red;
      int green = selectedColor.green;
      int blue = selectedColor.blue;
      db.categories.add([_controller.text, Color.fromARGB(alpha, red, green, blue)]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    await db.updateData();
  }

  //creates a new task
  void createCategory() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: (selectedColor) {
            saveCategory(selectedColor);
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: createCategory,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.categories.length,
        itemBuilder: (context, index) {
          return CategoryTile(
            categoryName: db.categories[index][0],
            categoryColor: db.categories[index][1],
            deleteFunction: (context) => deleteCategory(index),
          );
        },
      ),
    );
  }
}
