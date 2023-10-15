import 'package:expense_app/pages/categories.dart';
import 'package:expense_app/types/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Item {
  final String label;
  final bool isDestructive;

  const Item(this.label, this.isDestructive);
}

const items = [
  Item('Categories', false),
  Item('Erase all data', true),
];

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  void handleEraseData() {
    debugPrint("Tapped Erase Data");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 150,
      transformAlignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 28, 28, 30),
            borderRadius: BorderRadius.circular(16)),
        child: CupertinoFormSection.insetGrouped(
          margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          children: List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const Categories()));
                    break;

                  case 1:
                    showAlertDialog(context);
                }
              },
              child: DecoratedBox(
                decoration: const BoxDecoration(),
                child: CupertinoFormRow(
                  prefix: Text(
                    items[index].label,
                    style: TextStyle(
                        color: items[index].isDestructive
                            ? Colors.red
                            : Colors.white),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 15, 12, 16),
                  child: items[index].isDestructive
                      ? Container()
                      : const Icon(Icons.keyboard_arrow_right_sharp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Simple Alert"),
    content: const Text("This is an alert message."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
