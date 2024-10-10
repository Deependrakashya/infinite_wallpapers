import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

Widget image(AsyncSnapshot<ClusturedPhotos> snapshot,int index){
  return Container(
                              height: 200,
                              margin: const EdgeInsets.all(10),
                              child: Image.network(snapshot
                                  .data!.photos![index].src!.medium
                                  .toString(),fit: BoxFit.cover,),
                            );
}
PreferredSizeWidget AppBar2(String title,Color mycolor){
  return AppBar(
    title: Text(title),
    backgroundColor: mycolor,
  );
}