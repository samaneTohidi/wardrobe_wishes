
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSheet extends StatefulWidget {
  const ImageSheet({super.key});

  @override
  State<ImageSheet> createState() => _ImageSheetState();
}
class _ImageSheetState extends State<ImageSheet> {
  @override
  Widget build(BuildContext context) {

    Size screenSize =  MediaQuery.of(context).size;
    double buttonWidth = screenSize.width * 0.5;
    double arrowDownHeight = screenSize.height * 0.05;


    return Column(
      children: [
        Container(
          height: arrowDownHeight,
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.keyboard_arrow_down_outlined), onPressed: () {
            Navigator.pop(context);
          },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: buttonWidth,
              child: FilledButton(
                onPressed: () {
                  // Handle image from gallery
                },
                child: Text('Image from gallery'),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width:buttonWidth,
              child: FilledButton(
                onPressed: () {
                  // Handle image from camera
                },
                child: Text('Camera'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



void showImageModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const FractionallySizedBox(
        heightFactor: 0.2,
        widthFactor: 1,
        child: ImageSheet(),
      );
    },
  );
}
