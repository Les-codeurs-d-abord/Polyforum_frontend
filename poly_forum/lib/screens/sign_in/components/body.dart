import 'package:flutter/material.dart';
import 'package:poly_forum/utils/constants.dart';
import 'package:poly_forum/screens/sign_in/components/sign_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildInitialScreen(context);
  }

  Widget buildInitialScreen(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1100) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: SignForm(),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: kPrimaryColor,
                  child: Center(
                    child: Image.asset(
                      "images/interview_1.png",
                      width: 700,
                      height: 700,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SingleChildScrollView(
            child: SignForm(),
          );
        }
      },
    );
  }
}
