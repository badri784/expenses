import 'package:expenses/widget/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.7),
              margin: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white, size: 40),
            ),
            onDismissed: (direction) => onRemoveExpense(expenses[index]),
            child: ExpensesItem(expense: expenses[index]),
          ),
    );
  }
}
