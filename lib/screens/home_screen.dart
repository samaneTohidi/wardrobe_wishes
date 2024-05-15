import 'package:flutter/material.dart';
import 'package:wardrobe_wishes/screens/wish_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String _sortBy = 'Last added';

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _sizeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _sizeAnimation;

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

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double sortHeight = screenSize.height * 0.1;
    double wishListHeight = screenSize.height * 0.8;
    final List<Map<String, String>> items = [
      {"name": "Boot", "image": "boot.png"},
      {"name": "t_shirt", "image": "t_shirt.png"},
      {"name": "Boot", "image": "boot.png"},
    ];
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
                        _sortBy = 'First added';
                      });
                    },
                  ),
                  Text(
                    _sortBy,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ]),
              ),
              Container(
                height: wishListHeight,
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          trailing: Image.asset(
                            'assets/images/${items[index]['image']!}',
                            fit: BoxFit.fill,
                          ),
                          title: Text(items[index]['name']!),
                        ),
                      );
                    }),
              ),
              Container(
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showWishModalBottomSheet(context);
                  },

                ),
              ),
            ],
          )),
    );
  }
}
