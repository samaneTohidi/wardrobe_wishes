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
  late final AnimationController _fadeController;
  late final AnimationController _sizeController;

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
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    )..repeat(reverse: true);

    _fetchCategories();

    super.initState();

  }

  @override
  void dispose() {
    _fadeController.dispose();
    _sizeController.dispose();
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sortHeight = screenSize.height * 0.1;
    double wishListHeight = screenSize.height * 0.8;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.teal[600]),
          child: Column(
            children: [
              Container(
                height: sortHeight,
                child: Row(children: [
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
                ]),
              ),
              Container(
                height: wishListHeight,
                child: ListView.builder(
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          trailing: Image.asset(
                            'assets/images/t_shirt.png',
                            fit: BoxFit.fill,
                          ),
                          title: Text(_categories[index].name),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return DetailScreen( cat: _categories[index], onCategoryDeleted: _handleCategoryDeleted,);
                                })
                            );
                          },
                        ),
                      );
                    }),
              ),
               Container(
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    showWishModalBottomSheet(context);
                  },

                ),
              ),
            ],
          )),
    );
  }

  void showWishModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.9,
          child: WishScreen(cats: _categories,
              onCatsUpdated: _updateCategories),
        );
      },
    );
  }
}

