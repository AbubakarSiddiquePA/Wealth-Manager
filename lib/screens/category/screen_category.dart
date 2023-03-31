import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';

import 'expense_category_test_grid.dart';
import 'income_category_test_grid.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBar(
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color.fromARGB(255, 25, 206, 179),
              ),
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Text(
                  "INCOME",
                  style: GoogleFonts.acme(fontSize: 22),
                ),
                Text(
                  "EXPENSE",
                  style: GoogleFonts.acme(fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                IncomeCategoryListTest(),
                ExpenseCategoryListTest(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
