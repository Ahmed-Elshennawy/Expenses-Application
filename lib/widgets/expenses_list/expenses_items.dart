import 'package:app3/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 30,
      // margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${expense.amount.toStringAsFixed(2)} \$',
                ),
                // const SizedBox(width: 15),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    // const CircularProgressIndicator.adaptive(),
                    const SizedBox(width: 5),
                    Text(expense.formmatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
