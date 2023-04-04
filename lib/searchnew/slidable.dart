import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/edittransactions/edit_transactions.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/screens/addtransaction/screen_add_transaction.dart';
import 'package:money_manager_db/searchnew/search_.dart';

class SlidableTransaction extends StatelessWidget {
  const SlidableTransaction({super.key, required this.transaction});

  // final TransactionModel transaction;
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    log("slidble  build");

    return Slidable(
      key: Key(transaction.id!),
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: (ctx) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text(
                  'Alert',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                  ),
                ),
                content: const Text('Are you sure to Delete'),
                actions: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await TransactionDb.instance
                              .deleteTransaction(transaction.id!);
                          searchfield.refreshshowList();

                          Navigator.of(ctx).pop();
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          icon: Icons.delete_forever,
          label: 'Delete?',
          backgroundColor: Colors.red,
        ),
        SlidableAction(
          onPressed: (ctx) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => EditTransactions(
                  id: transaction.id,
                  type: transaction.type,
                  date: transaction.date,
                  amount: transaction.amount,
                  purpose: transaction.purpose,
                  category: transaction.category,
                ),
              ),
            );
          },
          icon: Icons.edit,
          label: 'Edit',
          backgroundColor: Colors.grey,
        )
      ]),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        elevation: 20,
        child: ListTile(
          trailing: Text(
            transaction.category.name,
            style: GoogleFonts.acme(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: CircleAvatar(
              maxRadius: 22,
              child: Text(
                parseDate(transaction.date),
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(),
              ),
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: transaction.category.type == CategoryType.income
                  ? "+ "
                  : "- ",
              style: TextStyle(
                color: transaction.category.type == CategoryType.income
                    ? Colors.green
                    : Colors.red,
              ),
              children: [
                TextSpan(
                    text: "₹  ${transaction.amount}",
                    style: GoogleFonts.acme(
                      fontSize: 18,
                      color: transaction.category.type == CategoryType.income
                          ? Colors.green
                          : Colors.red,
                    )),
              ],
            ),
          ),
          subtitle: Text(
            transaction.purpose,
            style: GoogleFonts.actor(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
