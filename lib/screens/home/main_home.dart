import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/screens/transactions/screen_transaction.dart';

import 'package:money_manager_db/search/on_search_page.dart';
import 'package:money_manager_db/searchnew/search_.dart';

import '../../models/transactions/transaction_model.dart';

class BalanceCard extends StatelessWidget {
  double? totalBalance;
  double? totalIncome;
  double? totalExpenses;

  @override
  Widget build(BuildContext context) {
    overViewListNotifier.value =
        TransactionDb.instance.transactionListNotifier.value;
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifier,
      builder: (context, List<TransactionModel> value, _) {
        totalBalance = 0;
        totalExpenses = 0;
        totalIncome = 0;
        TransactionDb.instance.transactionListNotifier.value.forEach((element) {
          if (element.type == CategoryType.income) {
            totalIncome = (totalIncome! + element.amount);
          } else {
            totalExpenses = (totalExpenses! + element.amount);
          }
          totalBalance = totalIncome! - totalExpenses!;
        });
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.white, Colors.grey]),
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.currency_rupee,
                          color: Colors.black,
                        )),
                    Text("Total Balance",
                        style: GoogleFonts.acme(fontSize: 20)),
                    Text(
                      "Rs. $totalBalance",
                      style: GoogleFonts.acme(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.white, Colors.grey]),
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          const Icon(Icons.arrow_downward, color: Colors.green),
                    ),
                    const SizedBox(width: 8.0),
                    Text("Income", style: GoogleFonts.acme(fontSize: 18)),
                    const SizedBox(width: 16.0),
                    Text(
                      "Rs. $totalIncome",
                      style: GoogleFonts.acme(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.white, Colors.grey]),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_upward, color: Colors.red),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      "Expense",
                      style: GoogleFonts.acme(fontSize: 18),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "Rs. $totalExpenses",
                      style: GoogleFonts.acme(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transactions", style: GoogleFonts.acme(fontSize: 20)),
                    TextButton(
                        onPressed: () {
                          CategoryDb.instance.getCategories();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Search()));
                        },
                        child: Text(
                          'View All',
                          style: GoogleFonts.acme(),
                        ))
                  ],
                ),
                const Expanded(child: ScreenTransaction())
              ],
            ),
          ),
        );
      },
    );
  }
}

// List<TransactionDb> getIncomeTransactions(List<TransactionDb> transactions) {
//   return transactions
//       .where((transaction) => CategoryType.income == 'income')
//       .toList();
// }

// List<TransactionDb> getExpenseTransactions(List<TransactionDb> transactions) {
//   return transactions
//       .where((transaction) => CategoryType.expense == 'expense')
//       .toList();
// }

// List<TransactionDb> incomeTransactions =
//     getIncomeTransactions(incomeTransactions);
// List<TransactionDb> expenseTransactions =
//     getExpenseTransactions(incomeTransactions);
