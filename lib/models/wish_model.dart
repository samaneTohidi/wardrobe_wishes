import '../repositories/wish_database.dart';

class WishModel {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final String link;
  final String note;

  WishModel(
      {required this.id,
        required this.name,
      required this.categoryId,
      required this.image,
      required this.link,
      required this.note,
      });

  factory WishModel.fromData(Item item) {
    return WishModel(
      id: item.id,
      name: item.name,
      categoryId: item.categoryId,
      image: item.image ?? '',
      link: item.link?? '',
      note: item.note ?? '',
    );
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromData(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
    );
  }
}