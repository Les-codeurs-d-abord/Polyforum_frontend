import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomConfirmationAlert extends StatefulWidget {
  final String title, descriptions;

  const CustomConfirmationAlert(
      {Key? key, required this.title, required this.descriptions})
      : super(key: key);

  @override
  _CustomConfirmationAlertState createState() =>
      _CustomConfirmationAlertState();
}

class _CustomConfirmationAlertState extends State<CustomConfirmationAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "widget.text",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: Constants.padding,
        //     right: Constants.padding,
        //     child: CircleAvatar(
        //       backgroundColor: Colors.transparent,
        //       radius: Constants.avatarRadius,
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
        //           child: Image.asset("assets/model.jpeg")
        //       ),
        //     ),
        // ),
      ],
    );
  }
}
