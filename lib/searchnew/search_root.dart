import 'package:flutter/material.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/searchnew/search_.dart';
import 'package:money_manager_db/searchnew/searchtile.dart';

ValueNotifier<List<TransactionModel>> searchResult = ValueNotifier([]);

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            searchfield(),
            Expanded(
              child: SearchTiles(),
            ),
          ],
        ),
      ),
    );
  }
}
