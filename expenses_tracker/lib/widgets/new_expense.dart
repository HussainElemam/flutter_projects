import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _titleController.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);

    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (cxt) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
            'Please make sure a valid title, amount, date and category were entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(cxt);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        amount: enteredAmount,
        date: _selectedDate!,
        title: _titleController.text,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardHeight),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text('\$ '),
                      label: Text('Amount'),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No date is selected'
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _showDatePicker,
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                // Text('Pick date'),
                // IconButton(
                //   onPressed: _showDatePicker,
                //   icon: Icon(Icons.calendar_month),
                // ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
