import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/pie_chart.dart';
import 'package:expense_tracker/models/expense.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({
    super.key, 
    required this.buckets,
  });

  final List<ExpenseBucket> buckets;

  double get total {
    return buckets.fold(0, (sum, bucket) => sum + bucket.totalExpenses);
  } 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.onPrimary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: -10,
                blurRadius: 7,
                offset: const Offset(-5, -5),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: -2,
                blurRadius: 10,
                offset: const Offset(7, 7),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraint.maxWidth * 0.6,
                  child: CustomPaint(
                    foregroundPainter: PieChart(
                      width: constraint.maxWidth * 0.5,
                      buckets: buckets,
                    ),
                    child: const Center(),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraint.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(-1, -1),
                        color: Colors.grey.withOpacity(0.25),
                      ),
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: const Offset(5, 5),
                        color: Colors.grey.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Center(
                    child: Text('\£${(total).toStringAsFixed(2)}'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}