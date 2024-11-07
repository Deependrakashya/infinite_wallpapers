import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/getx.dart';

Widget customButton(MyController controller, String title) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      gradient: controller.setWallpaperLoader.value
          ? LinearGradient(colors: [Colors.yellow, Colors.black])
          : LinearGradient(colors: [Colors.grey, Colors.grey]),
    ),
    child: Container(
      height: 30,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
