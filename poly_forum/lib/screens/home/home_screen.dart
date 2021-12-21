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
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future(() => true);
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: kScaffoldColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              color: Colors.blue,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: double.infinity,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text(
                        "Les offres",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  width: 290,
                  height: 210,
                  color: Colors.green,
                ),
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
