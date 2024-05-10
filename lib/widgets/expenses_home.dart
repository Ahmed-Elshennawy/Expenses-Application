import 'package:app3/widgets/chart/chart.dart';
import 'package:app3/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '/models/expense.dart';
import 'expenses_list/expenses_lists.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // ThemeMode _currentThemeMode = ThemeMode.light;

  // void _toggleTheme() {
  //   setState(() {
  //     _currentThemeMode = _currentThemeMode == ThemeMode.light
  //         ? ThemeMode.dark
  //         : ThemeMode.light;
  //   });
  // }

  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.work,
      title: 'Working',
      amount: 29.9,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.leisure,
      title: 'Camera',
      amount: 13.6,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.food,
      title: 'Breakfast',
      amount: 50.9,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.brightness_6), // Icon for theme toggle
          //   onPressed: _toggleTheme,
          // ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (ctx) => NewExpense(onAddExpense: _addExpense),
              );
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
      ),
    );
  }
}
