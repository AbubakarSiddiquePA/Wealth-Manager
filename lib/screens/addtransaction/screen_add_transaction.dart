import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:intl/intl.dart';

import 'category_add_only_pop.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routName = 'add-transactions';

  const ScreenAddTransaction(BuildContext context, {super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        title: const Text('Add Transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 10, 92, 130)),
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text("income")
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 10, 92, 130)),
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      const Text("Expense")
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your purpose';
                        }
                        return null;
                      },
                      controller: _purposeTextEditingController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.abc,
                          color: Color.fromARGB(255, 10, 92, 130),
                        ),
                        hintText: 'Enter your Purpose',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 10, 92, 130),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 17, 163, 176),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  Amount';
                        }
                        return null;
                      },
                      controller: _amountTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.currency_rupee,
                          color: Color.fromARGB(255, 10, 92, 130),
                        ),
                        hintText: 'Amount',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 10, 92, 130),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 17, 163, 176),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton.icon(
                  onPressed: () async {
                    final selectDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now()
                          .subtract(const Duration(days: 10 * 365)),
                      lastDate: DateTime.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.fromSwatch(
                              primarySwatch: Colors.blueGrey,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (selectDateTemp == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedDate = selectDateTemp;
                      });
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 10, 92, 130),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                  label: Text(
                    _selectedDate == null
                        ? 'select date'
                        : parseDate(_selectedDate!),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              //copy
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable:
                            CategoryDb().expenseCategoryListListner,
                        builder: (context, value, child) =>
                            ValueListenableBuilder(
                          // li

                          //     CategoryDB().IncomeCategoryList,
                          valueListenable:
                              CategoryDb().incomeCategoryListListner,
                          builder: (context, value, child) =>
                              DropdownButton<String>(
                            borderRadius: BorderRadius.circular(20),
                            dropdownColor: Colors.grey[900],
                            icon: const Icon(Icons.arrow_drop_down),
                            hint: const Text('Select category'),
                            value: _categoryID,
                            items: (_selectedCategorytype == CategoryType.income
                                    ? CategoryDb().incomeCategoryListListner
                                    : CategoryDb().expenseCategoryListListner)
                                .value
                                .map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  e.name,
                                  style: GoogleFonts.acme(),
                                ),
                                onTap: () {
                                  (" ${CategoryDb().incomeCategoryListListner.value.length}");
                                  _selectedCategorymodel = e;
                                },
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
                              setState(() {
                                _categoryID = selectedValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 17),
                  IconButton(
                    onPressed: () {
                      addcategoryPopup(
                          context: context,
                          selectedcategorytype: _selectedCategorytype);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.white, Colors.grey]),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.add_circle,
                        color: Color.fromARGB(255, 10, 92, 130),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addTransaction();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all required fields!'
                                // style: TextStyle(color: Colors.red),
                                ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green
                        // backgroundColor: const Color.fromARGB(255, 17, 163, 176),
                        ),
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }

    if (_selectedCategorymodel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
        type: _selectedCategorytype!,
        category: _selectedCategorymodel!,
        id: DateTime.now().millisecondsSinceEpoch.toString());

    await TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();

    AnimatedSnackBar.rectangle(
      'Success',
      'Transaction Added Successfully',
      type: AnimatedSnackBarType.success,
      brightness: Brightness.light,
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}

String parseDate(DateTime selectedDate) {
  return DateFormat.MMMd().format(selectedDate);
}
