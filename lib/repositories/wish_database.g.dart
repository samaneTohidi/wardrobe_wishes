// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with drift.TableInfo<$CategoriesTable, Category> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta =
      const drift.VerificationMeta('id');
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const drift.VerificationMeta _nameMeta =
      const drift.VerificationMeta('name');
  @override
  late final drift.GeneratedColumn<String> name = drift.GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<drift.GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  drift.VerificationContext validateIntegrity(
      drift.Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends drift.DataClass implements drift.Insertable<Category> {
  final int id;
  final String name;
  const Category({required this.id, required this.name});
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['name'] = drift.Variable<String>(name);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category copyWith({int? id, String? name}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.id == this.id && other.name == this.name);
}

class CategoriesCompanion extends drift.UpdateCompanion<Category> {
  final drift.Value<int> id;
  final drift.Value<String> name;
  const CategoriesCompanion({
    this.id = const drift.Value.absent(),
    this.name = const drift.Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const drift.Value.absent(),
    required String name,
  }) : name = drift.Value(name);
  static drift.Insertable<Category> custom({
    drift.Expression<int>? id,
    drift.Expression<String>? name,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoriesCompanion copyWith(
      {drift.Value<int>? id, drift.Value<String>? name}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = drift.Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with drift.TableInfo<$ItemsTable, Item> {
  @override
  final drift.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const drift.VerificationMeta _idMeta =
      const drift.VerificationMeta('id');
  @override
  late final drift.GeneratedColumn<int> id = drift.GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const drift.VerificationMeta _categoryIdMeta =
      const drift.VerificationMeta('categoryId');
  @override
  late final drift.GeneratedColumn<int> categoryId = drift.GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES categories(id)');
  static const drift.VerificationMeta _nameMeta =
      const drift.VerificationMeta('name');
  @override
  late final drift.GeneratedColumn<String> name = drift.GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const drift.VerificationMeta _imageMeta =
      const drift.VerificationMeta('image');
  @override
  late final drift.GeneratedColumn<String> image =
      drift.GeneratedColumn<String>('image', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const drift.VerificationMeta _linkMeta =
      const drift.VerificationMeta('link');
  @override
  late final drift.GeneratedColumn<String> link = drift.GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const drift.VerificationMeta _noteMeta =
      const drift.VerificationMeta('note');
  @override
  late final drift.GeneratedColumn<String> note = drift.GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const drift.VerificationMeta _isDoneMeta =
      const drift.VerificationMeta('isDone');
  @override
  late final drift.GeneratedColumn<bool> isDone = drift.GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_done" IN (0, 1))'),
      defaultValue: drift.Constant(false));
  @override
  List<drift.GeneratedColumn> get $columns =>
      [id, categoryId, name, image, link, note, isDone];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  drift.VerificationContext validateIntegrity(drift.Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = drift.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    return context;
  }

  @override
  Set<drift.GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends drift.DataClass implements drift.Insertable<Item> {
  final int id;
  final int categoryId;
  final String name;
  final String? image;
  final String? link;
  final String? note;
  final bool isDone;
  const Item(
      {required this.id,
      required this.categoryId,
      required this.name,
      this.image,
      this.link,
      this.note,
      required this.isDone});
  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    map['id'] = drift.Variable<int>(id);
    map['category_id'] = drift.Variable<int>(categoryId);
    map['name'] = drift.Variable<String>(name);
    if (!nullToAbsent || image != null) {
      map['image'] = drift.Variable<String>(image);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = drift.Variable<String>(link);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = drift.Variable<String>(note);
    }
    map['is_done'] = drift.Variable<bool>(isDone);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: drift.Value(id),
      categoryId: drift.Value(categoryId),
      name: drift.Value(name),
      image: image == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(image),
      link: link == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(link),
      note: note == null && nullToAbsent
          ? const drift.Value.absent()
          : drift.Value(note),
      isDone: drift.Value(isDone),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
      link: serializer.fromJson<String?>(json['link']),
      note: serializer.fromJson<String?>(json['note']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= drift.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String?>(image),
      'link': serializer.toJson<String?>(link),
      'note': serializer.toJson<String?>(note),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  Item copyWith(
          {int? id,
          int? categoryId,
          String? name,
          drift.Value<String?> image = const drift.Value.absent(),
          drift.Value<String?> link = const drift.Value.absent(),
          drift.Value<String?> note = const drift.Value.absent(),
          bool? isDone}) =>
      Item(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        name: name ?? this.name,
        image: image.present ? image.value : this.image,
        link: link.present ? link.value : this.link,
        note: note.present ? note.value : this.note,
        isDone: isDone ?? this.isDone,
      );
  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('note: $note, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryId, name, image, link, note, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.image == this.image &&
          other.link == this.link &&
          other.note == this.note &&
          other.isDone == this.isDone);
}

class ItemsCompanion extends drift.UpdateCompanion<Item> {
  final drift.Value<int> id;
  final drift.Value<int> categoryId;
  final drift.Value<String> name;
  final drift.Value<String?> image;
  final drift.Value<String?> link;
  final drift.Value<String?> note;
  final drift.Value<bool> isDone;
  const ItemsCompanion({
    this.id = const drift.Value.absent(),
    this.categoryId = const drift.Value.absent(),
    this.name = const drift.Value.absent(),
    this.image = const drift.Value.absent(),
    this.link = const drift.Value.absent(),
    this.note = const drift.Value.absent(),
    this.isDone = const drift.Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const drift.Value.absent(),
    required int categoryId,
    required String name,
    this.image = const drift.Value.absent(),
    this.link = const drift.Value.absent(),
    this.note = const drift.Value.absent(),
    this.isDone = const drift.Value.absent(),
  })  : categoryId = drift.Value(categoryId),
        name = drift.Value(name);
  static drift.Insertable<Item> custom({
    drift.Expression<int>? id,
    drift.Expression<int>? categoryId,
    drift.Expression<String>? name,
    drift.Expression<String>? image,
    drift.Expression<String>? link,
    drift.Expression<String>? note,
    drift.Expression<bool>? isDone,
  }) {
    return drift.RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (link != null) 'link': link,
      if (note != null) 'note': note,
      if (isDone != null) 'is_done': isDone,
    });
  }

  ItemsCompanion copyWith(
      {drift.Value<int>? id,
      drift.Value<int>? categoryId,
      drift.Value<String>? name,
      drift.Value<String?>? image,
      drift.Value<String?>? link,
      drift.Value<String?>? note,
      drift.Value<bool>? isDone}) {
    return ItemsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      image: image ?? this.image,
      link: link ?? this.link,
      note: note ?? this.note,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  Map<String, drift.Expression> toColumns(bool nullToAbsent) {
    final map = <String, drift.Expression>{};
    if (id.present) {
      map['id'] = drift.Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = drift.Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = drift.Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = drift.Variable<String>(image.value);
    }
    if (link.present) {
      map['link'] = drift.Variable<String>(link.value);
    }
    if (note.present) {
      map['note'] = drift.Variable<String>(note.value);
    }
    if (isDone.present) {
      map['is_done'] = drift.Variable<bool>(isDone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('link: $link, ')
          ..write('note: $note, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends drift.GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  @override
  Iterable<drift.TableInfo<drift.Table, Object?>> get allTables =>
      allSchemaEntities.whereType<drift.TableInfo<drift.Table, Object?>>();
  @override
  List<drift.DatabaseSchemaEntity> get allSchemaEntities => [categories, items];
}

typedef $$CategoriesTableInsertCompanionBuilder = CategoriesCompanion Function({
  drift.Value<int> id,
  required String name,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  drift.Value<int> id,
  drift.Value<String> name,
});

class $$CategoriesTableTableManager extends drift.RootTableManager<
    _$MyDatabase,
    $CategoriesTable,
    Category,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableProcessedTableManager,
    $$CategoriesTableInsertCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder> {
  $$CategoriesTableTableManager(_$MyDatabase db, $CategoriesTable table)
      : super(drift.TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTableFilterComposer(drift.ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTableOrderingComposer(drift.ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CategoriesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            drift.Value<int> id = const drift.Value.absent(),
            drift.Value<String> name = const drift.Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
          ),
          getInsertCompanionBuilder: ({
            drift.Value<int> id = const drift.Value.absent(),
            required String name,
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
          ),
        ));
}

class $$CategoriesTableProcessedTableManager
    extends drift.ProcessedTableManager<
        _$MyDatabase,
        $CategoriesTable,
        Category,
        $$CategoriesTableFilterComposer,
        $$CategoriesTableOrderingComposer,
        $$CategoriesTableProcessedTableManager,
        $$CategoriesTableInsertCompanionBuilder,
        $$CategoriesTableUpdateCompanionBuilder> {
  $$CategoriesTableProcessedTableManager(super.$state);
}

class $$CategoriesTableFilterComposer
    extends drift.FilterComposer<_$MyDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer(super.$state);
  drift.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ComposableFilter itemsRefs(
      drift.ComposableFilter Function($$ItemsTableFilterComposer f) f) {
    final $$ItemsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.items,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder, parentComposers) => $$ItemsTableFilterComposer(
            drift.ComposerState(
                $state.db, $state.db.items, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends drift.OrderingComposer<_$MyDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer(super.$state);
  drift.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ItemsTableInsertCompanionBuilder = ItemsCompanion Function({
  drift.Value<int> id,
  required int categoryId,
  required String name,
  drift.Value<String?> image,
  drift.Value<String?> link,
  drift.Value<String?> note,
  drift.Value<bool> isDone,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  drift.Value<int> id,
  drift.Value<int> categoryId,
  drift.Value<String> name,
  drift.Value<String?> image,
  drift.Value<String?> link,
  drift.Value<String?> note,
  drift.Value<bool> isDone,
});

class $$ItemsTableTableManager extends drift.RootTableManager<
    _$MyDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableProcessedTableManager,
    $$ItemsTableInsertCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder> {
  $$ItemsTableTableManager(_$MyDatabase db, $ItemsTable table)
      : super(drift.TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ItemsTableFilterComposer(drift.ComposerState(db, table)),
          orderingComposer:
              $$ItemsTableOrderingComposer(drift.ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$ItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            drift.Value<int> id = const drift.Value.absent(),
            drift.Value<int> categoryId = const drift.Value.absent(),
            drift.Value<String> name = const drift.Value.absent(),
            drift.Value<String?> image = const drift.Value.absent(),
            drift.Value<String?> link = const drift.Value.absent(),
            drift.Value<String?> note = const drift.Value.absent(),
            drift.Value<bool> isDone = const drift.Value.absent(),
          }) =>
              ItemsCompanion(
            id: id,
            categoryId: categoryId,
            name: name,
            image: image,
            link: link,
            note: note,
            isDone: isDone,
          ),
          getInsertCompanionBuilder: ({
            drift.Value<int> id = const drift.Value.absent(),
            required int categoryId,
            required String name,
            drift.Value<String?> image = const drift.Value.absent(),
            drift.Value<String?> link = const drift.Value.absent(),
            drift.Value<String?> note = const drift.Value.absent(),
            drift.Value<bool> isDone = const drift.Value.absent(),
          }) =>
              ItemsCompanion.insert(
            id: id,
            categoryId: categoryId,
            name: name,
            image: image,
            link: link,
            note: note,
            isDone: isDone,
          ),
        ));
}

class $$ItemsTableProcessedTableManager extends drift.ProcessedTableManager<
    _$MyDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableProcessedTableManager,
    $$ItemsTableInsertCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder> {
  $$ItemsTableProcessedTableManager(super.$state);
}

class $$ItemsTableFilterComposer
    extends drift.FilterComposer<_$MyDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer(super.$state);
  drift.ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<String> get link => $state.composableBuilder(
      column: $state.table.link,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  drift.ColumnFilters<bool> get isDone => $state.composableBuilder(
      column: $state.table.isDone,
      builder: (column, joinBuilders) =>
          drift.ColumnFilters(column, joinBuilders: joinBuilders));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableFilterComposer(drift.ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$ItemsTableOrderingComposer
    extends drift.OrderingComposer<_$MyDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer(super.$state);
  drift.ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<String> get image => $state.composableBuilder(
      column: $state.table.image,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<String> get link => $state.composableBuilder(
      column: $state.table.link,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  drift.ColumnOrderings<bool> get isDone => $state.composableBuilder(
      column: $state.table.isDone,
      builder: (column, joinBuilders) =>
          drift.ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $state.db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CategoriesTableOrderingComposer(drift.ComposerState($state.db,
                $state.db.categories, joinBuilder, parentComposers)));
    return composer;
  }
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
}
