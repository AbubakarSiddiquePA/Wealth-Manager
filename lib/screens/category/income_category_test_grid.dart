import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';
import 'package:money_manager_db/screens/home/screen_home.dart';

class IncomeCategoryListTest extends StatelessWidget {
  const IncomeCategoryListTest({Key? key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeCategoryListListner,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          if (newList.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/453-savings-pig-outline (3).gif',
                ),
                const Text('No Categories Yet!')
              ],
            );
          } else {
            return ValueListenableBuilder(
              valueListenable: listTransitions,
              builder: (context, value, child) {
                if (value) {
                  return GridView.count(
                    childAspectRatio: 2.0,
                    crossAxisCount: 2, // number of columns in the grid
                    crossAxisSpacing: 5, // spacing between columns
                    mainAxisSpacing: 10, // spacing between rows
                    children: List.generate(newList.length, (index) {
                      final category = newList[index];
                      return Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(60))),
                        child: ListTile(
                          title: Expanded(
                              child: Text(
                            category.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.acme(fontSize: 20),
                          )),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
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
                                            CategoryDb.instance
                                                .deleteCategory(category.id);
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
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final category = newList[index];

                      return Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(60))),
                        child: ListTile(
                          title: Text(
                            category.name,
                            style: GoogleFonts.acme(fontSize: 20),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
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
                                            CategoryDb.instance
                                                .deleteCategory(category.id);
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
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: newList.length,
                  );
                }
              },
            );
          }
        });
  }
}
