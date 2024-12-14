import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_pie.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 49.95,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Gym Membership',
      amount: 22.0,
      date: DateFormat('dd/MM/yyyy').parse('15/08/2024'),
      category: Category.health,
    ),
    Expense(
      title: 'Flight to Paris',
      amount: 209.38,
      date: DateFormat('dd/MM/yyyy').parse('27/10/2024'),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense)
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${expense.title} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(child: Text('No expenses yet. Add some!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent =
        ExpensesList(
          expenses: _registeredExpenses, 
          onRemoveExpense: _removeExpense,
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExpenseTracker',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: width < 600 ? Column(
        children: [
          SizedBox(
            height: height * 0.35,
            child: ChartPie(expenses: _registeredExpenses), 
          ),
          Expanded(child: mainContent),
        ],
      ) : Row(
        children: [
          SizedBox(
            width: width * 0.45,
            child: ChartPie(expenses: _registeredExpenses,
          ),),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}