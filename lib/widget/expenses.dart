import 'package:expenses/widget/chart/chart.dart';
import 'package:expenses/widget/expenses_list/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expenses/models/expense.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _list = [
    Expense(
      title: "cinema",
      amount: 350,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "dart course",
      amount: 123,
      date: DateTime.now(),
      category: Category.education,
    ),
    Expense(
      title: "travel",
      amount: 700,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "mechanical course",
      amount: 545,
      date: DateTime.now(),
      category: Category.education,
    ),
    Expense(
      title: "breakfast",
      amount: 180,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "maintenance",
      amount: 109,
      date: DateTime.now(),
      category: Category.other,
    ),
  ];
  void addExpense(Expense expense) {
    setState(() {
      _list.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      _list.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => NewExpenses(addExpense),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: Center(
        child:
            (width > 600 || isLandscape)
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Chart(expenses: _list)),
                    Expanded(
                      child:
                          _list.isEmpty
                              ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "No expenses found! ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.add_box),
                                  ],
                                ),
                              )
                              : ExpensesList(
                                expenses: _list,
                                onRemoveExpense: removeExpense,
                              ),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Chart(expenses: _list)),
                    Expanded(
                      child:
                          _list.isEmpty
                              ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "No expenses Yet!",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.add_box_outlined),
                                  ],
                                ),
                              )
                              : Expanded(
                                child: ExpensesList(
                                  expenses: _list,
                                  onRemoveExpense: removeExpense,
                                ),
                              ),
                    ),
                  ],
                ),
      ),
    );
  }
}
