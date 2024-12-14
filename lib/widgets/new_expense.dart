import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context, 
          builder: (ctx) =>
            CupertinoAlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please enter a valid title, amount, date, and category'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            )
          );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please enter a valid title, amount, date, and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleInputField(controller: _titleController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AmountInputField(controller: _amountController),
                      ),
                    ],
                  )
                else
                  TitleInputField(controller: _titleController),
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: CategoryDropdown(
                          selectedCategory: _selectedCategory,
                          onSelected: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: DatePickerField(
                          selectedDate: _selectedDate,
                          onDatePicked: _presentDatePicker,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: AmountInputField(controller: _amountController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePickerField(
                          selectedDate: _selectedDate,
                          onDatePicked: _presentDatePicker,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (width < 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CategoryDropdown(
                        selectedCategory: _selectedCategory,
                        onSelected: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 100,
                      child: FilledButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TitleInputField extends StatelessWidget {
  final TextEditingController controller;

  const TitleInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 50,
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
    );
  }
}

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        prefixText: '£ ',
        labelText: 'Amount',
      ),
      keyboardType: TextInputType.number,
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final Category? selectedCategory;
  final ValueChanged<Category?> onSelected;

  const CategoryDropdown({
    Key? key,
    required this.selectedCategory,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<Category>(
      initialSelection: selectedCategory,
      dropdownMenuEntries: Category.values.map((category) {
        return DropdownMenuEntry<Category>(
          value: category,
          label:
              '${category.name[0].toUpperCase()}${category.name.substring(1).toLowerCase()}',
          leadingIcon: Icon(categoryIcons[category]),
        );
      }).toList(),
      label: const Text('Category'),
      onSelected: onSelected,
    );
  }
}

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onDatePicked;

  const DatePickerField({
    Key? key,
    required this.selectedDate,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'No Date Chosen'
              : formatter.format(selectedDate!),
        ),
        IconButton(
          onPressed: onDatePicked,
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
    );
  }
}
