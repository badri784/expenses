import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses(this.onAddExpense, {super.key});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final titleInputbyuser = TextEditingController();
  final amontInputbyuser = TextEditingController();
  DateTime? packeddate;
  final dateformatter = DateFormat.yMd();
  Category _selesctedcategory = Category.other;
  @override
  void dispose() {
    titleInputbyuser.dispose();
    amontInputbyuser.dispose();
    super.dispose();
  }

  void getdialog() {
    Platform.isIOS
        ? showCupertinoDialog(
          context: context,
          builder:
              (ctx) => AlertDialog.adaptive(
                actionsOverflowButtonSpacing: 5,
                scrollable: true,
                title: const Text("Error"),
                content: const Text(
                  "Please enter a valid title, amount, and date.",
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Okay"),
                  ),
                ],
              ),
        )
        : showDialog(
          context: context,
          builder:
              (ctx) => AlertDialog(
                actionsOverflowButtonSpacing: 5,
                scrollable: true,
                title: const Text("Error"),
                content: const Text(
                  "Please enter a valid title, amount, and date.",
                ),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Okay"),
                  ),
                ],
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),

          child: Column(
            children: [
              TextField(
                controller: titleInputbyuser,
                maxLength: 30,
                decoration: InputDecoration(
                  label: const Text("Title", style: TextStyle(fontSize: 18)),
                ),
              ),
              TextField(
                controller: amontInputbyuser,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  label: const Text("amount", style: TextStyle(fontSize: 18)),
                  prefixText: "\$",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton(
                    value: _selesctedcategory,
                    items:
                        Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                    onChanged: (cat) {
                      if (cat == null) {
                        return;
                      } else {
                        setState(() {
                          _selesctedcategory = cat;
                          log(_selesctedcategory.name);
                        });
                      }
                    },
                  ),
                  Spacer(),
                  Text(
                    packeddate == null
                        ? "No Date Selected"
                        : dateformatter.format(packeddate!),
                  ),
                  IconButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final first = DateTime(now.year - 4, now.month, now.day);
                      final last = DateTime(now.year + 1, now.month, now.day);
                      final datepiker = await showDatePicker(
                        context: context,
                        firstDate: first,
                        lastDate: last,
                        initialDate: now,
                      );
                      setState(() {
                        packeddate = datepiker;
                        log(packeddate.toString());
                      });
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final enteramount = double.tryParse(
                        amontInputbyuser.text,
                      );
                      final amounttisinvalied =
                          enteramount == null || enteramount <= 0;
                      //const snackBar = SnackBar(content: Text("Error"));

                      if (titleInputbyuser.text.trim().isEmpty ||
                          amounttisinvalied ||
                          packeddate == null) {
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // Duration(seconds: 5);
                        getdialog();
                      } else {
                        widget.onAddExpense(
                          Expense(
                            title: titleInputbyuser.text,
                            amount: enteramount,
                            date: packeddate!,
                            category: _selesctedcategory,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add Expense"),
                  ),
                  SizedBox(width: 35),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel ?"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
