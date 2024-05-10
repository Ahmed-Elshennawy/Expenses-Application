import 'package:flutter/material.dart';

import '/widgets/expenses_list/expenses_items.dart';
import '../../models/expense.dart';

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
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          margin: Theme.of(context).cardTheme.margin,
          // margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpensesItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
