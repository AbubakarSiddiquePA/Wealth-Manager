import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_db/db/categorydb/category_db.dart';
import 'package:money_manager_db/models/category/category_model.dart';

final _formKey = GlobalKey<FormState>();

ValueNotifier<CategoryType> selectedcategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Text(
                'Add Category below',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                RadioButton(
                  title: 'Income',
                  type: CategoryType.income,
                ),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                    controller: _nameEditingController,
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
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    if (_formKey.currentState!.validate()) {
                      final _type = selectedcategoryNotifier.value;
                      final _category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type,
                      );
                      AnimatedSnackBar.rectangle(
                        'Success',
                        'Category Added Successfully',
                        type: AnimatedSnackBarType.success,
                        brightness: Brightness.light,
                        duration: const Duration(seconds: 4),
                      ).show(context);

                      CategoryDb.instance.insertCategory(_category);
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text("Add"),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedcategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              fillColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromARGB(255, 10, 92, 130)),
              value: type,
              groupValue: newCategory,
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                selectedcategoryNotifier.value = value;

                selectedcategoryNotifier.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
