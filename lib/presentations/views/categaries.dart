import 'package:flutter/material.dart';

import 'package:infinite_wallpapers/getx.dart';

Widget categories(
  String title,
  String imgUrl,
  MyController controller,
) {
  return InkWell(
    splashColor: Colors.yellow,
    onTap: () {
      controller.searchPexelsImages(title);
    },
    child: Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.yellow, Colors.black]),
        image: DecorationImage(
          fit: BoxFit.cover, // Use cover to fill the container with the image
          image: AssetImage(imgUrl),
        ),
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
    ),
  );
}

Widget animeCatagories(String title, MyController controller, String q) {
  return InkWell(
    splashColor: Colors.yellow,
    onTap: () {
      controller.searchAnimePhotos(q);
    },
    child: Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.yellow, Colors.black]),
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
    ),
  );
}
