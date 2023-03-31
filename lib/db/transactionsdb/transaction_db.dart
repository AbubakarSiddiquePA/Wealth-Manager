import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/search/on_search_page.dart';

const transactiondbName = 'transaction-Db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future deleteTransaction(String id);
  Future<void> editTransaction(TransactionModel obj, String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(transactiondbName);
    await _db.put(obj.id, obj);
  }

  Future refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);

    // transactionListNotifier.value.add(_list.);
    transactionListNotifier.notifyListeners();
    allList.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _db = await Hive.openBox<TransactionModel>(transactiondbName);

    return _db.values.toList();
  }

  @override
  Future deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(transactiondbName);
    await _db.delete(id);
    refresh();
  }

  @override
  Future<void> editTransaction(TransactionModel obj, String id) async {
    final _db = await Hive.openBox<TransactionModel>(transactiondbName);
    for (var element in _db.keys) {
      log("${element.toString()}");
    }

    log(" function ${id}");
    await _db.put(id, obj);

    await getAllTransactions();

    await refresh();
    transactiontype.notifyListeners();
    listToDisplay.notifyListeners();
  }
}
