import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseStatics extends StatelessWidget {
  CategoryType incomeOrExpense;
  ExpenseStatics({required this.incomeOrExpense, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TransactionModel>>(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> incomeorexpense, _) {
          var allExpenseOrincome = incomeorexpense
              .where((element) => element.type == incomeOrExpense)
              .toList();
          var groupedExpensorIncome = groupBy<TransactionModel, String>(
            allExpenseOrincome,
            (expenseorIncome) => expenseorIncome.category.name,
          );
          var data = groupedExpensorIncome.entries
              .map((e) => MapEntry<String, double>(
                  e.key,
                  e.value.fold(
                      0,
                      (total, expenseOrIncome) =>
                          total + expenseOrIncome.amount)))
              .toList();
          return Scaffold(
            backgroundColor: const Color.fromARGB(128, 90, 89, 89),
            body: Column(
              children: [
                Expanded(
                  child: data.isNotEmpty
                      ? SfCircularChart(
                          series: <CircularSeries>[
                            DoughnutSeries(
                                dataSource: data,
                                xValueMapper: (entry, _) => entry.key,
                                yValueMapper: (entry, _) => entry.value,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true)),
                          ],
                          legend: Legend(
                              isVisible: true,
                              backgroundColor: Colors.white,
                              // position: LegendPosition.bottom,
                              textStyle: GoogleFonts.acme()),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Image.asset(
                                  'lib/assets/images/153-bar-chart-growth-outline (3).gif'),
                              const Text(
                                'No graphs to display!',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
