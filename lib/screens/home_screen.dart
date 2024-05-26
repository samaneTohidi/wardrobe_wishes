import 'package:flutter/material.dart';
import 'package:wardrobe_wishes/screens/detail_screen.dart';
import 'package:wardrobe_wishes/screens/widgets/sort_sheet.dart';
import 'package:wardrobe_wishes/screens/wish_screen.dart';

import '../repositories/wish_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Category> _categories = [];
  SortData? _sortBy = SortData.lastAdded;

  final _db = MyDatabase.instance;

  void _updateCategories(List<Category> newCategories) {
    setState(() {
      _categories = newCategories;
    });
  }

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchCategories() async {
    final categories = await _db.getCategoriesSortedBy(_sortBy!);
    setState(() {
      _categories = categories;
    });
  }

  void _handleCategoryDeleted() {
    _fetchCategories();
  }

  void _handleSort(SortData? newSort) {
    setState(() {
      _sortBy = newSort;
    });
    _fetchCategories();
  }


  Future<void> _deleteCat(int catId) async {
    await MyDatabase.instance.deleteCategory(catId);
    await _fetchCategories();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.teal[600]),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 32.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.sort),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        showSortModalBottomSheet(context, _sortBy, _handleSort);
                      });
                    },
                  ),
                  Text(
                    _sortBy!.description ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                        key: Key(_categories[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          await _deleteCat(_categories[index].id);
                        },

                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                          child:
                          const Icon(Icons.delete, color: Colors.white),
                        ),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        // trailing: Image.asset(
                        //   'assets/images/t_shirt.png',
                        //   fit: BoxFit.fill,
                        // ),
                        title: Text(_categories[index].name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DetailScreen(
                                cat: _categories[index],
                                onCategoryDeleted: _handleCategoryDeleted,
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showWishModalBottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showWishModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.7,
          child: WishScreen(
            cats: _categories,
            onCatsUpdated: _updateCategories,
          ),
        );
      },
    );
  }
}
