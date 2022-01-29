import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final double width;
  final EdgeInsets childPadding;

  const BaseScreen(
      {required this.child,
      this.childPadding =
          const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      this.width = 1200,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (constext, constraint) {
      if (constraint.maxWidth > 1024) {
        return buildWebVersion();
      } else {
        return buildPhoneVersion();
      }
    });
  }

  Widget buildWebVersion() {
    return SingleChildScrollView(
      primary: false,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Material(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: SizedBox(
                  width: width,
                  child: Padding(
                    padding: childPadding,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhoneVersion() {
    return SingleChildScrollView(
      primary: false,
      child: Center(
        child: Container(
          color: Colors.grey[50],
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: childPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
