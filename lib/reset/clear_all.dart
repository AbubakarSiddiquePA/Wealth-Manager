import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';

import '../SplashScreen/splash.dart';
import '../db/transactionsdb/transaction_db.dart';

Future<void> resetAllData(BuildContext context) async {
  if (Splashscreens.getdata().isEmpty) {
    log('is empty');
  } else {
    await Splashscreens.getdata().clear();
  }

  final categoryDB = await Hive.openBox<CategoryModel>(categorydbname);

  categoryDB.clear();

  // ignore: non_constant_identifier_names
  final TransactionDB = await Hive.openBox<TransactionModel>(transactiondbName);
  TransactionDB.clear();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const SplashOne(),
    ),
  );
}
