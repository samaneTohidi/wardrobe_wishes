import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortSheet extends StatefulWidget {
  SortData? sortBy;
  final ValueChanged<SortData?> onSortChanged;

  SortSheet({super.key , required this.sortBy ,required this.onSortChanged});


  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {


  @override
  Widget build(BuildContext context) {

    return  Column(
      children: <Widget>[
        ListTile(
          title: const Text('Last added'),
          leading: Radio<SortData>(
            value: SortData.lastAdded,
            groupValue: widget.sortBy,
            onChanged: (SortData? value) {
              setState(() {
                widget.onSortChanged(value);
                widget.sortBy = value;
              });
              Navigator.pop(context);
            },
          ),
        ),
        ListTile(
          title: const Text('First added'),
          leading: Radio<SortData>(
            value: SortData.firstAdded,
            groupValue: widget.sortBy,
            onChanged: (SortData? value) {
              setState(() {
                widget.onSortChanged(value);
                widget.sortBy = value;
              });
              Navigator.pop(context);
            },
          ),
        ),

        ListTile(
          title: const Text('Alphabetical'),
          leading: Radio<SortData>(
            value: SortData.alphabetical, groupValue: widget.sortBy,
            onChanged: (SortData? value){
              setState(() {
                widget.onSortChanged(value);
                widget.sortBy = value;
              });
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}

enum SortData {
  lastAdded, firstAdded, alphabetical;

  String get description{
     switch(this){
       case SortData.firstAdded:
      return 'First added';
       case SortData.lastAdded:
      return 'Last added';
       case SortData.alphabetical:
      return'Alphabetical';
     }
  }
  @override
  String toString() {
    return description;
  }

}

void showSortModalBottomSheet(BuildContext context, SortData? sortBy, ValueChanged<SortData?> onSortChanged) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return  FractionallySizedBox(
        heightFactor: 0.2,
        widthFactor: 1,
        child: SortSheet(onSortChanged: onSortChanged , sortBy: sortBy,)
      );
    },
  );
}