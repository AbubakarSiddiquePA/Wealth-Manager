import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_manager_db/models/category/category_model.dart';

const categorydbname = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(categorydbname);
    await _categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(categorydbname);

    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();
    // refreshUI();
    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListner.value.add(category);
        } else {
          expenseCategoryListListner.value.add(category);
        }
      },
    );

    incomeCategoryListListner.notifyListeners();
    expenseCategoryListListner.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categorydbname);
    _categoryDB.delete(categoryID);
    refreshUI();
  }
}
