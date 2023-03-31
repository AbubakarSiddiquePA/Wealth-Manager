import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/edittransactions/edit_transactions.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/screens/addtransaction/screen_add_transaction.dart';
import 'package:money_manager_db/search/on_search_page.dart';

Widget viewAll(BuildContext context, List<TransactionModel> transactions, _) {
  return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (ctx, index) {
      final _value = transactions[index];
      return Slidable(
        key: Key(_value.id!),
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
                          onPressed: () {
                            showList.value.removeAt(index);
                            TransactionDb.instance
                                .deleteTransaction(_value.id!);

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
                    id: _value.id,
                    type: _value.type,
                    date: _value.date,
                    amount: _value.amount,
                    purpose: _value.purpose,
                    category: _value.category,
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
              _value.category.name,
              style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25,
              child: CircleAvatar(
                maxRadius: 22,
                child: Text(
                  parseDate(_value.date),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.acme(),
                ),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: _value.category.type == CategoryType.income ? "+ " : "- ",
                style: TextStyle(
                  color: _value.category.type == CategoryType.income
                      ? Colors.green
                      : Colors.red,
                ),
                children: [
                  TextSpan(
                      text: "₹  ${_value.amount}",
                      style: GoogleFonts.acme(
                        fontSize: 18,
                        color: _value.category.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                      )),
                ],
              ),
            ),
            subtitle: Text(
              _value.purpose,
              style: GoogleFonts.actor(color: Colors.grey),
            ),
          ),
        ),
      );
    },
    separatorBuilder: (ctx, index) {
      return const SizedBox(
        height: 10,
      );
    },
    itemCount: transactions.length,
  );
}
