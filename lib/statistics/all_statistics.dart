import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Allstatics extends StatelessWidget {
  const Allstatics({Key? key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(128, 90, 89, 89),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: TransactionDb.instance.transactionListNotifier,
              builder: (BuildContext context,
                  List<TransactionModel> transactions, _) {
                double expense = 0;
                double income = 0;
                for (var transaction in transactions) {
                  if (transaction.type == CategoryType.expense) {
                    expense = expense + transaction.amount;
                  } else {
                    income = income + transaction.amount;
                  }
                }

                Map incomeMap = {'Name': 'income', 'Amount': income};
                Map expenseMap = {'Name': 'expense', 'Amount': expense};

                List<Map> transactionMap = [incomeMap, expenseMap];
                return TransactionDb
                        .instance.transactionListNotifier.value.isNotEmpty
                    ? Expanded(
                        child: SfCircularChart(
                          series: <CircularSeries>[
                            DoughnutSeries<Map, String>(
                              dataSource: transactionMap,
                              xValueMapper: (Map data, _) => data['Name'],
                              yValueMapper: (Map data, _) => data['Amount'],
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                            ),
                          ],
                          legend: Legend(
                              isVisible: true,
                              backgroundColor: Colors.white,
                              // position: LegendPosition.,
                              textStyle: GoogleFonts.acme()),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Image.asset(
                              'lib/assets/images/153-bar-chart-growth-outline (3).gif',
                            ),
                            const Text(
                              'No graphs to display!',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
