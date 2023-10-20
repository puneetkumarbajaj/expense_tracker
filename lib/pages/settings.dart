import 'package:expense_app/pages/categories.dart';
import 'package:expense_app/types/widgets.dart';

import 'package:flutter/material.dart';

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  void handleEraseData() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 150,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 28, 28, 30),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Categories"),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Categories(),
                    ));
              },
            ),
            ListTile(
                title: const Text(
                  "Erase All Data",
                  style: TextStyle(color: Colors.red),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    actions: <Widget>[
                      TextButton(
                        onPressed: handleEraseData,
                        child: const Text('Cancel' , style: TextStyle(color: Colors.blue),),
                      ),
                      TextButton(
                        onPressed: handleEraseData,
                        child: const Text('Erase Data', style: TextStyle(color: Colors.red),),
                      )
                    ],
                    title: Text("Are you sure"),
                    backgroundColor: Color.fromARGB(255, 28, 28, 30),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              )
          ],
        ),
      ),
    );
  }
}
