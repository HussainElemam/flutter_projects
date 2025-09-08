import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final _allBuckets = ExpenseBucket.getAllBuckets(expenses);

    var _maxBucket = _allBuckets[0];
    for (int i = 1; i < _allBuckets.length; ++i) {
      if (_allBuckets[i].totalExpenses > _maxBucket.totalExpenses) {
        _maxBucket = _allBuckets[i];
      }
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withAlpha(80),
          ],
          begin: AlignmentGeometry.bottomCenter,
          end: AlignmentGeometry.topCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (ExpenseBucket eBucket in _allBuckets)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    width: 75,
                    child: FractionallySizedBox(
                      heightFactor:
                          eBucket.totalExpenses / _maxBucket.totalExpenses,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (ExpenseBucket eBucket in _allBuckets)
                Icon(expenseIcon[eBucket.category]),
            ],
          ),
        ],
      ),
    );
  }
}
