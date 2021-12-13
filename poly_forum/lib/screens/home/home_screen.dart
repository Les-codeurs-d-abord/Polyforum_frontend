import 'package:flutter/material.dart';
import 'package:poly_forum/constants.dart';

class HomeScreen extends StatefulWidget {
  static const route = "/Home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future(() => true);
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: kScaffoldColor,
          body: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              Container(
                width: 290,
                height: 210,
                color: Colors.green,
              ),
              Container(
                width: 250,
                height: 170,
                color: Colors.red,
              ),
              Container(
                width: 220,
                height: 150,
                color: Colors.yellow,
              ),
            ],
          ),
        ));
  }
}
