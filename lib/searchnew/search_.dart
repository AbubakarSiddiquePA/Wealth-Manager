import 'package:flutter/material.dart';
import 'package:money_manager_db/db/transactionsdb/transaction_db.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/search/on_search_page.dart';

final TextEditingController searchQueryController = TextEditingController();
ValueNotifier<List<TransactionModel>> overViewListNotifier = ValueNotifier([]);

class searchfield extends StatelessWidget {
  const searchfield({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: searchQueryController,
            onChanged: (value) async {
              searchResult(value);
            },
            decoration: InputDecoration(
                // prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                    overViewListNotifier.value =
                        TransactionDb.instance.transactionListNotifier.value;
                    searchQueryController.clear();
                    searchResult(searchQueryController.text);
                    showList.notifyListeners();
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  static void refreshshowList() {
    searchResult(searchQueryController.text);
    showList.notifyListeners();
  }

  static searchResult(String value) {
    if (value.isEmpty) {
      showList.value = TransactionDb.instance.transactionListNotifier.value;
    } else {
      showList.value = TransactionDb.instance.transactionListNotifier.value
          .where((element) =>
              element.category.name
                  .toLowerCase()
                  .contains(value.trim().toLowerCase()) ||
              element.purpose.contains(value.toLowerCase().trim()))
          .toList();
    }
  }
}
