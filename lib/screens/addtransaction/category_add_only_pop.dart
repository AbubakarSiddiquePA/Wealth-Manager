import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';

Future<void> addcategoryPopup({context, required selectedcategorytype}) async {
  final formkey = GlobalKey<FormState>();
  final nameeditingcontroller = TextEditingController();

  await showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Center(child: Text('Add Category')),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: TextFormField(
                  controller: nameeditingcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter category';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.abc,
                      color: Color.fromARGB(255, 10, 92, 130),
                    ),
                    hintText: 'Category Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 10, 92, 130),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 17, 163, 176),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  'sdddddds';
                }

                final name = nameeditingcontroller.text;
                if (name.isEmpty) {
                  return;
                }
                final category = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    type: selectedcategorytype);
                AnimatedSnackBar.rectangle(
                  'Done',
                  'Entry added to Category',
                  type: AnimatedSnackBarType.success,
                  brightness: Brightness.light,
                  duration: const Duration(seconds: 4),
                ).show(context);
                CategoryDb.instance.insertCategory(category);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Add'),
            )
          ],
        );
      });
}
