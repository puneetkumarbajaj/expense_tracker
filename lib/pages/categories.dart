import 'package:expense_app/types/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  TextEditingController _taskController = TextEditingController();

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        transformAlignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: CupertinoFormSection.insetGrouped(
                margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: CupertinoFormRow(
                        prefix: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 9),
                              decoration: BoxDecoration(
                                color: pickerColor,
                                shape: BoxShape.circle,
                              ),
                              width: 12,
                              height: 12,
                            ),
                            Text("Category Name"),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(16, 15, 12, 16),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: pickerColor,
                                onColorChanged: changeColor,
                              ),
                              // Use Material color picker:
                              //
                              // child: MaterialPicker(
                              //   pickerColor: pickerColor,
                              //   onColorChanged: changeColor,
                              //   showLabel: true, // only on portrait mode
                              // ),
                              //
                              // Use Block color picker:
                              //
                              // child: BlockPicker(
                              //   pickerColor: currentColor,
                              //   onColorChanged: changeColor,
                              // ),
                              //
                              // child: MultipleChoiceBlockPicker(
                              //   pickerColors: currentColors,
                              //   onColorsChanged: changeColors,
                              // ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber)),
                                child: const Text('Got it'),
                                onPressed: () {
                                  setState(() => currentColor = pickerColor);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: pickerColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: 4,
                                strokeAlign: BorderSide.strokeAlignOutside)),
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 12),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          child: TextField(
                            controller: _taskController,
                            decoration: const InputDecoration(
                              labelText: 'Category Name',
                              // labelStyle: TextStyle(color: Colors.white),
                              fillColor: Color.fromARGB(255, 28, 28,
                                  30), // Change the background color
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text("B"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
