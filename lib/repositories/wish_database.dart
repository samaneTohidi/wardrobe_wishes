import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/drift.dart' as drift;

import '../screens/widgets/sort_sheet.dart';


part 'wish_database.g.dart';

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
}

class Items extends Table {

  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId => integer().customConstraint('NOT NULL REFERENCES categories(id)')();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  TextColumn get image => text().nullable()();

  TextColumn get link => text().nullable()();

  TextColumn get note => text().nullable()();

  BoolColumn get isDone => boolean().withDefault( Constant(false))();

}

@DriftDatabase(tables: [Categories, Items])
class MyDatabase extends _$MyDatabase {

  MyDatabase._internal() : super(_openConnection());

  static final MyDatabase instance = MyDatabase._internal();

  Future<List<Item>> getItems() async {
    return await select(items).get();
  }

  Future<List<Category>> getCategories() async {
    return await select(categories).get();

  }

  Future<List<Item>> getItemsByCategoryIdAndDoneStatus(int categoryId, bool isDone) async {
    return (select(items)
      ..where((tbl) => tbl.categoryId.equals(categoryId))
      ..where((tbl) => tbl.isDone.equals(isDone)))
        .get();
  }

  Future<int> addItem(ItemsCompanion item) async {
    return into(items).insert(item);
  }

  Future<void> deleteItem(int itemId) async {
    await (delete(items)..where((tbl) => tbl.id.equals(itemId))).go();
  }

  Future<int> addCategory(CategoriesCompanion category) async {
    return into(categories).insert(category);
  }

  Future<void> deleteCategory(int categoryId) async {
    await (delete(categories)..where((tbl) => tbl.id.equals(categoryId))).go();
  }

  Future<Category?> getCategoryByName(String name) async {
    return (select(categories)..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
  }

  Future<List<Item>> getItemsByCategoryId(int categoryId) async {
    return (select(items)..where((tbl) => tbl.categoryId.equals(categoryId))).get();
  }

  Future<List<Category>> getCategoriesSortedBy(SortData sortBy) async {
    final query = select(categories);
    switch (sortBy) {
      case SortData.firstAdded:
        query.orderBy([(t) => OrderingTerm(expression: t.id)]);
        break;
      case SortData.lastAdded:
        query.orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]);
        break;
      case SortData.alphabetical:
        query.orderBy([(t) => OrderingTerm(expression: t.name)]);
        break;
    }
    return query.get();
  }

  Future<void> addCategoryWithItems(CategoriesCompanion category, List<ItemsCompanion> items) async {
    return transaction(() async {
      final existingCategory = await getCategoryByName(category.name.value);

      int categoryId;
      if (existingCategory != null) {
        categoryId = existingCategory.id;
      } else {
        categoryId = await addCategory(category);
      }

      for (var item in items) {
        await addItem(item.copyWith(categoryId: drift.Value(categoryId)));
      }
    });
  }

  Future<void> updateItemStatus(int itemId, bool isDone) async {
    await (update(items)..where((tbl) => tbl.id.equals(itemId)))
        .write(ItemsCompanion(isDone: Value(isDone)));
  }


  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}