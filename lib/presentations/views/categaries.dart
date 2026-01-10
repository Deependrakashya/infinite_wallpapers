import 'package:flutter/material.dart';
import 'package:zen_walls/getx.dart';

Widget categories(String title, String imgUrl, MyController controller) {
  return InkWell(
    onTap: () {
      controller.searchPexelsImages(title);
    },
    child: Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black45,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
          image: AssetImage(imgUrl),
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
  );
}

Widget animeCatagories(String title, MyController controller, String q) {
  return InkWell(
    onTap: () {
      controller.searchAnimePhotos(q);
    },
    child: Container(
      height: 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
  );
}
