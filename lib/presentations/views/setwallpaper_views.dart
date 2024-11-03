import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/getx.dart';

Widget customButton(MyController controller, void myFunc, String title) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      gradient: LinearGradient(colors: [Colors.yellow, Colors.black]),
    ),
    child: MaterialButton(
        onPressed: () {
          myFunc;
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        )),
  );
}
