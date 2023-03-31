import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/models/transactions/transaction_model.dart';
import 'package:money_manager_db/screens/addtransaction/screen_add_transaction.dart';

import 'SplashScreen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  Hive.registerAdapter(SplashscreensAdapter());
  if (!Hive.isBoxOpen('Splashscreens')) {
    await Hive.openBox<Splashscreens>('Splashscreens');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const SplashOne(),
      routes: {
        ScreenAddTransaction.routName: (ctx) => ScreenAddTransaction(context),
      },
    );
  }
}
