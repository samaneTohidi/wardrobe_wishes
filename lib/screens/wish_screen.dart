import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:wardrobe_wishes/screens/widgets/cat_dropdown_menu.dart';
import 'package:wardrobe_wishes/screens/widgets/image_sheet.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({super.key});

  @override
  State<WishScreen> createState() => _WishScreenState();
}

class _WishScreenState extends State<WishScreen> {
  late TextEditingController _titleController;
  late TextEditingController _linkController;
  late TextEditingController _noteController;
  late GlobalKey<FormState> _formKey;




  @override
  void initState() {
    _titleController = TextEditingController();
    _linkController = TextEditingController();
    _noteController= TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool _isValidURL(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double arrowDownHeight = screenSize.height * 0.05;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: arrowDownHeight,
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.keyboard_arrow_down_outlined), onPressed: () {
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
                      CatDropdownMenu()
                    ],
                  ),
                  SizedBox(height: 12),
                  // Add Image
                  Column(
                    children: [
                      Row(
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
                    Navigator.pop(context);
                  }, child: const Text('Make a wish'))
            ],
          ),

        ),

    );
  }

}

void showWishModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: WishScreen(),
      );
    },
  );
}
