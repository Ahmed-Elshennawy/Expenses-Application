import 'package:app3/models/expense.dart';
import 'package:app3/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (ctx, constraint) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        width: double.infinity,
        height: constraint.maxHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.primary.withOpacity(0.0),
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
                  for (final element in buckets)
                    ChartBar(
                      fill: element.totalExpenses == 0
                          ? 0
                          : element.totalExpenses / maxTotalExpense,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: buckets
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[e.category],
                          color: isDarkMode
                              ? Theme.of(context).colorScheme.primary
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
    });
  }
}
