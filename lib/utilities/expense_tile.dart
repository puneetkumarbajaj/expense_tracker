import 'package:flutter/material.dart';

class ExpenseDisplay extends StatelessWidget {
  final int amount;
  final String occurence;
  final DateTime date;
  final String note;
  final String category;

  ExpenseDisplay(
      {super.key,
      required this.amount,
      required this.occurence,
      required this.date,
      required this.note,
      required this.category});

  late final String categoryColors = category;
  late final String categoryText = category.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date.toString().split(' ')[0]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    // color: categoryColors,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(categoryText),
              ],
            ),
            Text(amount.toString()),
          ],
        ),
      ),
    );
  }
}
