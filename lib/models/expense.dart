import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateformat = DateFormat.yMd();

enum Category { food, travel, leisure, work, other, education }

const categoryIcons = {
  Category.food: Icons.food_bank_outlined,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.question_mark,
  Category.education: Icons.school,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatterdate {
    return dateformat.format(date);
  }
}

class Expensebucket {
  final Category category;
  final List<Expense> expenses;

  Expensebucket({required this.category, required this.expenses});
  Expensebucket.forCategory(List<Expense> allexpenses, this.category)
    : expenses =
          allexpenses.where((element) => element.category == category).toList();

  double get totalExpenses {
    double total = 0;
    for (var expens in expenses) {
      total += expens.amount;
    }
    return total;
  }
}
