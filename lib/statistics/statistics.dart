import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/screens/home/screen_home.dart';
import 'package:money_manager_db/statistics/all_statistics.dart';
import 'package:money_manager_db/statistics/icome_expense_statistics.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreenHome()),
                  );
                },
                icon: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.white, Colors.grey]),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Center(
                  child: Text(
                    'Insights',
                    style: GoogleFonts.acme(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              backgroundColor: const Color.fromARGB(128, 90, 89, 89),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  child: const TabBar(
                    labelColor: Colors.purple,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        color: Color.fromARGB(255, 25, 206, 179)),
                    tabs: [
                      Tab(
                        text: 'All',
                      ),
                      Tab(
                        text: 'Income',
                      ),
                      Tab(
                        text: 'Expense',
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(children: [
              const Allstatics(),
              ExpenseStatics(incomeOrExpense: CategoryType.income),
              ExpenseStatics(incomeOrExpense: CategoryType.expense),
            ]),
          )),
    );
  }
}
