import 'package:flutter/material.dart';

Widget Categaries(String title) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.blue, blurRadius: 5.0, blurStyle: BlurStyle.outer)
    ],
    borderRadius: BorderRadius.circular(10)
    ),
    child: Text(title),
  );
}
