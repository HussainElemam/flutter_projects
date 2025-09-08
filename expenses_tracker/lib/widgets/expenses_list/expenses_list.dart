import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(int) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(
            context,
          ).colorScheme.error.withAlpha((255 * 0.75).toInt()),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),

        key: ValueKey(expenses[index].id),
        child: ExpenseItem(expenses[index]),
        onDismissed: (direction) {
          onRemoveExpense(index);
        },
      ),
    );
  }
}
