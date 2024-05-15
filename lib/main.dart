import 'package:flutter/material.dart';
import 'package:wardrobe_wishes/screens/home_screen.dart';
import 'package:wardrobe_wishes/screens/wish_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(
          textColor: Colors.black
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


