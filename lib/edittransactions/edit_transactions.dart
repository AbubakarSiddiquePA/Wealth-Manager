import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/screens/addtransaction/category_add_only_pop.dart';
import 'package:money_manager_db/screens/addtransaction/screen_add_transaction.dart';

import '../db/categorydb/category_db.dart';
import '../models/category/category_model.dart';

//added values
class EditTransactions extends StatefulWidget {
  String? id;
  CategoryType type;
  double amount;
  String purpose;
  final DateTime date;
  final CategoryModel category;

  static const routName = 'add-transactions';

  EditTransactions(
      {super.key,
      required this.id,
      required this.type,
      required this.date,
      required this.amount,
      required this.purpose,
      required this.category});

  @override
  State<EditTransactions> createState() => _EditTransactionsstate();
}

//store updated values
class _EditTransactionsstate extends State<EditTransactions> {
  DateTime _selectedDate = DateTime.now();
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;
  String? _categoryID;

  late TextEditingController transactionamount;
  late TextEditingController transactionpurpose;
  final _formKey = GlobalKey<FormState>();
  late final String formattedDate;

  @override
  void initState() {
    _selectedCategorytype = widget.type;
    transactionamount = TextEditingController(text: widget.amount.toString());
    transactionpurpose = TextEditingController(text: widget.purpose);
    _selectedCategorymodel = widget.category;

    _selectedDate = widget.date;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 17, 163, 176),
        title: const Text('Edit Transaction'),
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
                      controller: transactionpurpose,
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
                      controller: transactionamount,
                      keyboardType: TextInputType.number,
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
                  ],
                ),
              ),
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
                          data: ThemeData.dark().copyWith(
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
                      ),
                    ),
                  ),
                  label: Text(
                    _selectedDate == null
                        ? 'select date'
                        : parseDate(_selectedDate),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
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
                            hint: Text(widget.category.name),
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
                      //add only popup
                      icon: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.white, Colors.grey]),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.add_circle,
                          color: Color.fromARGB(255, 10, 92, 130),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await updateTransaction();
                        Navigator.pop(context);
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateTransaction() async {
    widget.amount = double.parse(transactionamount.text);

    widget.purpose = transactionpurpose.text;
    final model = TransactionModel(
        purpose: widget.purpose,
        amount: widget.amount,
        // date: widget.date,
        date: _selectedDate,
        type: widget.type,
        category: _selectedCategorymodel!,
        id: widget.id);
    log(" edit funv${widget.id}");
    await TransactionDb.instance.editTransaction(model, widget.id!);
    await TransactionDb.instance.refresh();
  }
}
