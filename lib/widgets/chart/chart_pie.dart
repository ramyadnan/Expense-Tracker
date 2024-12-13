import 'package:expense_tracker/widgets/chart/categories_row.dart';
import 'package:expense_tracker/widgets/chart/pie_chart_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:expense_tracker/models/expense.dart';

class ChartPie extends StatelessWidget {
  const ChartPie({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.health),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: SizedBox(
        height: height * 0.3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: <Widget>[
              Text(
                'Total Expenses',
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buckets.map(
                          (bucket) => CategoriesRow(
                            icon: categoryIcons[bucket.category]!,
                            color: categoryColors[bucket.category]!,
                            category: bucket.category.toString().split('.').last,
                          ),
                        ).toList(),
                      ),
                    ),
                    PieChartView(buckets: buckets)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}