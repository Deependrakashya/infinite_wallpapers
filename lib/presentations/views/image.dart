import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

SliverAppBar MySliverAppBar(
    BuildContext context, bool searchTap, Function(bool) newSearchTap) {
  return SliverAppBar(
    title: Text('infinite_wallpapers'),
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    actions: [
      searchTap
          ? Center(
              child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    onSubmitted: (value) => print(' submit pressed'),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.all(5),
                          onPressed: () {
                            newSearchTap(false);
                          },
                          icon: Icon(
                            Icons.cancel,
                            size: 20,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  )),
            )
          : Container(
              child: IconButton(
                  onPressed: () {
                    newSearchTap(true);
                  },
                  icon: Icon(Icons.search)))
    ],
  );
}

Widget image(
    AsyncSnapshot<ClusturedPhotos> snapshot, int index, BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
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
