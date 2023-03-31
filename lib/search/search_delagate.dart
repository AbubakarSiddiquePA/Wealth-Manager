import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/search/view_all_card.dart';
import '../models/transactions/transaction_model.dart';

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
  // return '${date.day}\n${date.month}';
}

class CustomSearch extends SearchDelegate {
  List<TransactionModel> searchResult = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    searchResult = TransactionDb.instance.transactionListNotifier.value
        .where((element) =>
            element.category.name
                .toLowerCase()
                .contains(query.toLowerCase().trim()) ||
            element.purpose.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();

    if (searchResult.isEmpty) {
      return const Center(child: Text('No Search results found!'));
    } else {
      return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (context, value, child) {
          return viewAll(context, searchResult, child);
        },
      );
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    List<String> matchquery = [];

    searchResult = TransactionDb.instance.transactionListNotifier.value
        .where((element) =>
            element.category.name
                .toLowerCase()
                .contains(query.toLowerCase().trim()) ||
            element.purpose.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();

    if (searchResult.isEmpty) {
      return const Center(child: Text('No Search results found!'));
    } else {
      return ValueListenableBuilder(
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder: (context, value, child) {
          return viewAll(context, searchResult, child);
        },
      );
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Future<void> showResults(BuildContext context) async {
    super.showResults(context);
  }

  @override
  Future<void> showSuggestions(BuildContext context) async {
    super.showSuggestions(context);
  }
}
