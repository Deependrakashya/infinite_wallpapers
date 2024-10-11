import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

Widget image(
    AsyncSnapshot<ClusturedPhotos> snapshot, int index, BuildContext context) {
  return ClipRRect(
    borderRadius:BorderRadius.circular(20),
    child: Image.network(
      snapshot.data!.photos![index].src!.medium.toString(),
      fit: BoxFit.cover,
    height: double.infinity,
    ),
  );
}

PreferredSizeWidget AppBar2(String title, Color mycolor) {
  return AppBar(
    title: Text(title),
    backgroundColor: mycolor,
  );
}
