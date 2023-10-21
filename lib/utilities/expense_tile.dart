import 'package:flutter/material.dart';

class ExpenseDisplay extends StatelessWidget {
  final double amount;
  final String occurence;
  final String date;
  final String note;
  final List<Object> category;

  ExpenseDisplay(
      {super.key,
      required this.amount,
      required this.occurence,
      required this.date,
      required this.note,
      required this.category});

  late final Color categoryColors = category[1] as Color;
  late final String categoryText = category[0].toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: categoryColors,
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
