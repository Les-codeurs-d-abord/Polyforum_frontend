import 'package:flutter/material.dart';
import 'package:poly_forum/screens/candidate/profil/components/row_btn.dart';
import 'package:poly_forum/screens/shared/components/initials_avatar.dart';
import 'package:poly_forum/utils/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<int> _items = List<int>.generate(10, (int index) => index);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                width: 1000,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Organisation des voeux",
                        style: TextStyle(
                          color: kButtonColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ReorderableListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(15),
                      children: <Widget>[
                        for (int index = 0; index < _items.length; index++)
                          Card(
                            elevation: 15,
                            key: Key('$index'),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InitialsAvatar("Inetum"),
                                      Text("Consusltant technique SAP"),
                                      Text("Inetum"),
                                      Text(index.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final int item = _items.removeAt(oldIndex);
                          _items.insert(newIndex, item);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: RowBtn(text: 'Sauvegarder', onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
