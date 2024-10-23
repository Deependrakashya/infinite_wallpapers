import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

SliverAppBar MySliverAppBar(
    BuildContext context, bool searchTap, Function(bool) newSearchTap) {
  return SliverAppBar(
    title: const Text(
      'infinite wallpapers',
      style: TextStyle(color: Colors.white),
    ),
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      searchTap
          ? Center(
              child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    onSubmitted: (value) => print(' submit pressed'),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      suffixIcon: IconButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            newSearchTap(false);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            size: 20,
                          )),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      enabledBorder: const OutlineInputBorder(
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
                  icon: const Icon(
                    Icons.search,
                    color: Colors.yellow,
                  )))
    ],
  );
}

Widget image(
    AsyncSnapshot<ClusturedPhotos> snapshot, int index, BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Image.network(
      snapshot.data!.photos![index].src!.medium.toString(),
      fit: BoxFit.cover,
      height: double.infinity,
    ),
  );
}
