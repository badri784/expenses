// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:expenses/models/expense.dart';
import 'package:expenses/widget/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;
  List<Expensebucket> get buckets {
    return [
      Expensebucket.forCategory(expenses, Category.food),
      Expensebucket.forCategory(expenses, Category.travel),
      Expensebucket.forCategory(expenses, Category.leisure),
      Expensebucket.forCategory(expenses, Category.work),
      Expensebucket.forCategory(expenses, Category.other),
      Expensebucket.forCategory(expenses, Category.education),
    ];
  }

  get maxtotalexpense {
    double maxtotalexpense = 0;
    for (var element in buckets) {
      if (element.totalExpenses > maxtotalexpense) {
        maxtotalexpense = element.totalExpenses;
      }
    }

    return maxtotalexpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isdarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return LayoutBuilder(
      builder: (ctx, constraint) {
        log("Max Width ${constraint.maxWidth.toString()}");
        log("Max Height ${constraint.maxHeight.toString()}");
        log("Min Width ${constraint.minWidth.toString()}");
        log("Min Height ${constraint.minHeight.toString()}");

        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          width: double.infinity,
          height: constraint.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),

            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final ele in buckets)
                      ChartBar(
                        full:
                            ele.totalExpenses == 0
                                ? 0
                                : ele.totalExpenses / maxtotalexpense,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              constraint.minHeight < 200
                  ? Container()
                  : Row(
                    children:
                        buckets
                            .map(
                              (e) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  child: Icon(
                                    categoryIcons[e.category],
                                    color:
                                        isdarkmode
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.7),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
            ],
          ),
        );
      },
    );
  }
}
