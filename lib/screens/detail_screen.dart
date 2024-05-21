import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wardrobe_wishes/repositories/wish_database.dart';

class DetailScreen extends StatefulWidget {
  final Category cat;
  final VoidCallback onCategoryDeleted;

   DetailScreen({super.key , required this.cat , required this.onCategoryDeleted});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

String _sortBy = 'Last added';
List<Item> _doneItems = [];
List<Item> _notDoneItems = [];


class _DetailScreenState extends State<DetailScreen> {
  bool isChecked = false;


  @override
  void initState() {
    super.initState();
    _fetchItems();
  }


  Future<void> _fetchItems() async {
    final doneItems = await MyDatabase.instance.getItemsByCategoryIdAndDoneStatus(widget.cat.id, true);
    final notDoneItems = await MyDatabase.instance.getItemsByCategoryIdAndDoneStatus(widget.cat.id, false);
    setState(() {
      _doneItems = doneItems;
      _notDoneItems = notDoneItems;
    });
  }

  Future<void> _updateItemStatus(Item item, bool isDone) async {
    await MyDatabase.instance.updateItemStatus(item.id, isDone);
    await _fetchItems();
  }

  Future<void> _deleteItem(int itemId) async {
    await MyDatabase.instance.deleteItem(itemId);
    await _fetchItems();
    await _checkAndDeleteCategoryIfEmpty();

  }

  Future<void> _checkAndDeleteCategoryIfEmpty() async {
    final remainingItems = await MyDatabase.instance.getItemsByCategoryId(widget.cat.id);
    if (remainingItems.isEmpty) {
      await MyDatabase.instance.deleteCategory(widget.cat.id);
      widget.onCategoryDeleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sortHeight = screenSize.height * 0.1;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(widget.cat.name),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.done),
              ),
              Tab(
                icon: Icon(Icons.star),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Container(
                    height: sortHeight,
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.sort),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _sortBy = 'First added';
                          });
                        },
                      ),
                      Text(
                        _sortBy,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _doneItems.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(_doneItems[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async{
                              await _deleteItem(_doneItems[index].id);

                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                trailing: Image.asset(
                                  'assets/images/t_shirt.png',
                                  fit: BoxFit.fill,
                                ),
                                title: Text(_doneItems[index].name),

                              ),
                            ),
                          );
                        }
                        ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                   Container(
                    height: sortHeight,
                    child: Row(children: [
                      IconButton(
                        icon: const Icon(Icons.sort),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _sortBy = 'First added';
                          });
                        },
                      ),
                      Text(
                        _sortBy,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _notDoneItems.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(_notDoneItems[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async{
                              await _deleteItem(_notDoneItems[index].id);
                            },

                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                trailing: Image.asset(
                                  'assets/images/t_shirt.png',
                                  fit: BoxFit.fill,
                                ),
                                leading:
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: false, onChanged: (bool? value){
                                  setState(() {
                                    _updateItemStatus(_notDoneItems[index], value!);
                                  });
                                }),
                                title: Text(_notDoneItems[index].name),

                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

