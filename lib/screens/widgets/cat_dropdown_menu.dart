import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatDropdownMenu extends StatefulWidget {
  const CatDropdownMenu({super.key});

  @override
  State<CatDropdownMenu> createState() => _CatDropdownMenuState();
}

class _CatDropdownMenuState extends State<CatDropdownMenu> {
  final TextEditingController catController = TextEditingController();
  CatLabel? selectedCat;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CatLabel>(
        initialSelection: CatLabel.clothes,
        controller: catController,
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
    );
  }
}

enum CatLabel {
  clothes('Clothes', Icons.shopping_bag_outlined),
  bags('Bags', Icons.shopping_bag_outlined),
  shoes('Shoes', Icons.shopping_bag_outlined),
  accessories('Accessories', Icons.shopping_bag_outlined);

  const CatLabel(this.name, this.icon);

  final String name;
  final IconData icon;
}
