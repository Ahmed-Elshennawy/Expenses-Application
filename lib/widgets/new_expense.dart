import 'dart:io';

import 'package:app3/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formmater = DateFormat.yMd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _showDialog() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) => const CupertinoAlertDialog(
                  title: Text(
                    'Invaled input',
                    // style: TextStyle(color: Colors.white),
                  ),
                ))
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Invaled input',
                // style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Please fill the empty fields',
                // style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Okay'),
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
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                        prefixText: '\$ ',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formmater.format(_selectedDate!),
                          // style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now,
                            );
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  DropdownButton(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    // borderRadius: const BorderRadius.all(Radius.circular(20)),
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: const Color.fromARGB(255, 204, 101, 49),
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (newVal) {
                      setState(() {
                        if (newVal == null) {
                          return;
                        }
                        _selectedCategory = newVal;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final double? enteredAmount =
                          double.tryParse(_amountController.text);
                      final bool amountIsInvalid =
                          enteredAmount == null || enteredAmount <= 0;
                      if (_titleController.text.trim().isEmpty ||
                          amountIsInvalid ||
                          _selectedDate == null) {
                        _showDialog();
                      } else {
                        widget.onAddExpense(
                          Expense(
                            category: _selectedCategory,
                            title: _titleController.text,
                            amount: enteredAmount,
                            date: _selectedDate!,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Svae Expense'),
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
