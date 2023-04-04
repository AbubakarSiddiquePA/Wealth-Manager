import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_db/search/on_search_page.dart';
import 'package:money_manager_db/searchnew/search_.dart';
import 'package:money_manager_db/searchnew/slidable.dart';

class SearchTiles extends StatelessWidget {
  const SearchTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: overViewListNotifier,
      builder: (context, newList, child) {
        return newList.isEmpty
            ? const Center(
                child: Text('No Search results found'),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ValueListenableBuilder(
                  builder: (context, value, child) => ListView.separated(
                    itemBuilder: (context, index) {
                      // transactionModel transaction = newList[index];
                      return SlidableTransaction(transaction: value[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                    itemCount: showList.value.length,
                  ),
                  valueListenable: showList,
                ),
              );
      },
    );
  }
}

String parseDate(DateTime date) {
  return DateFormat.MMMd().format(date);
}
