import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({required this.expense, super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(expense.title),
            Row(
              children: [
                Text("\$ ${expense.amount.toStringAsFixed(1)}"),
                const Spacer(),
                Icon(categoryIcons[expense.category]),
                Row(children: [Text(expense.formatterdate)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
