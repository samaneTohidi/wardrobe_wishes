
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wardrobe_wishes/repositories/wish_database.dart';
import 'package:wardrobe_wishes/screens/widgets/cat_dropdown_menu.dart';
import 'package:wardrobe_wishes/screens/widgets/image_sheet.dart';


class WishScreen extends StatefulWidget {
  final List<Category> cats;
  final ValueChanged<List<Category>> onCatsUpdated;

  const WishScreen({super.key, required this.cats , required this.onCatsUpdated});

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _imageController;
  late TextEditingController _linkController;
  late TextEditingController _noteController;
  late GlobalKey<FormState> _formKey;
  final _db = MyDatabase.instance;
  CatLabel? selectedCat;


  @override
  void initState() {
    _titleController = TextEditingController();
    _linkController = TextEditingController();
    _noteController= TextEditingController();
    _categoryController = TextEditingController();
    _imageController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _noteController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  bool _isValidURL(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }
  void _saveData() async {

    final name = _titleController.text;
    final image = _imageController.text;
    final link = _linkController.text;
    final note = _noteController.text;
    final cat = _categoryController.text;
    final newCategory = CategoriesCompanion(
      name: drift.Value(cat),
    );

    final newItem = ItemsCompanion(
      name: drift.Value(name),
      image: drift.Value(image),
      link: drift.Value(link),
      note: drift.Value(note),
      categoryId: const drift.Value(0),
    );

    await _db.addCategoryWithItems(newCategory, [newItem]);
    final updatedCategories = await _db.getCategories();
    widget.onCatsUpdated(updatedCategories);
  }


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.05;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Container(
          child: Column(
            children: [
              Container(
                height: arrowDownHeight,
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_outlined), onPressed: () {
                  Navigator.pop(context);
                },
                ),
              ),

              Expanded(
              child:
              Column(
                children: [
                  Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: 'e.g.Gucci red bag',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        textAlign: TextAlign.center,
                        onSubmitted: (String value) async {
                          await showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('Thanks!'),
                                content: Text(
                                    'You typed "$value", which has length ${value.characters.length}.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                          },
                          );
                        },
                      ),
                DropdownMenu<CatLabel>(
                    initialSelection: CatLabel.clothes,
                    controller: _categoryController,
                    requestFocusOnTap: true,
                    onSelected: (CatLabel? cat) {
                      setState(() {
                        selectedCat = cat;
                      });
                    },
                    dropdownMenuEntries: CatLabel.values.map ((CatLabel cat ) {
                      return DropdownMenuEntry<CatLabel>(
                        value: cat,
                        label: cat.name,
                        enabled: cat.name != 'clothes',
                        leadingIcon: Icon(cat.icon),
                        style: MenuItemButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0), // Adjust padding

                        ),
                      );
                    }).toList()
                )
                    ],
                  ),
                  SizedBox(height: 12),
                  // Add Image
                  Column(
                    children: [
                       const Row(
                        children: [
                          Icon(
                            size: 24,
                            Icons.image_outlined,
                          ),
                          SizedBox(width: 8),
                          Text('Image')
                        ],
                      ),
                     IconButton.outlined(onPressed: (){
                       showImageModalBottomSheet(context);
                     }, icon: Icon(Icons.add))

                    ],
                  ),
                  SizedBox(height: 12),
                  // Add Link
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            size: 24,
                            Icons.add_link,
                          ),
                          SizedBox(width: 8),
                          Text('Link')
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _linkController,
                          decoration: const InputDecoration(
                            hintText: 'Add link',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          textAlign: TextAlign.start,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9:/\._-]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a link';
                            } else if (!_isValidURL(value)) {
                              return 'Please enter a valid link';
                            }
                            return null;
                          },
                          onFieldSubmitted: (String value) async {
                            if(_formKey.currentState?.validate() ?? false){
                              await showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  title: const Text('Thanks!'),
                                  content: Text(
                                      'You typed "$value", which has length ${value.characters.length}.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                              );
                            }

                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 12),
                  // Add Note
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            size: 24,
                            Icons.edit_note,
                          ),
                          SizedBox(width: 8),
                          Text('Note')
                        ],
                      ),
                      TextField(
                        controller: _noteController,
                        decoration: const InputDecoration(
                          hintText: 'Add note',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        textAlign: TextAlign.start,
                        onSubmitted: (String value) async {
                          await showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text(
                                  'You typed "$value", which has length ${value.characters.length}.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                          );
                        },
                      ),

                    ],
                  )

                ],
              ),
              ),
              FilledButton(
                  onPressed: (){
                    _saveData();
                    Navigator.pop(context);
                  }, child: const Text('Make a wish'))
            ],
          ),

        ),

    );
  }

}
