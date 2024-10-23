import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/const.dart';

Widget categories(String title, String imgUrl) {
  return Container(
    height: 50,
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(left: 40, right: 40),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.yellow, Colors.black]),
      image: DecorationImage(
        fit: BoxFit.cover, // Use cover to fill the container with the image
        image: AssetImage(imgUrl),
      ),
      // boxShadow: const [
      //   // BoxShadow(
      //   //   color: Color.fromARGB(255, 240, 217, 3),
      //   //   blurRadius: 5.0,
      //   //   blurStyle: BlurStyle.normal,
      //   // ),
      // ],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          shadows: [
            Shadow(
              blurRadius: 5.0,
              color: Colors.black,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    ),
  );
}
