import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:drift/drift.dart' as drift;


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

  Future<int> addItem(ItemsCompanion item) async {
    return into(items).insert(item);
  }

  Future<int> addCategory(CategoriesCompanion category) async {
    return into(categories).insert(category);
  }

  Future<Category?> getCategoryByName(String name) async {
    return (select(categories)..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
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