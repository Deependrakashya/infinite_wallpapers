import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

SliverAppBar MySliverAppBar(BuildContext context, MyController controller) {
  return SliverAppBar(
    title: const Text(
      'infinite wallpapers',
      style: TextStyle(color: Colors.white),
    ),
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      Obx(() => controller.getTouch.value
          ? Center(
              child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    onSubmitted: (value) => print(' submit pressed'),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    cursorColor: Colors.yellow,
                    cursorRadius: Radius.circular(10),
                    cursorWidth: 1,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      suffixIcon: IconButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            controller.toogleSearchBar();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.yellow,
                            size: 20,
                          )),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.yellow)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.yellow)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.yellow)),
                    ),
                  )),
            )
          : Container(
              child: IconButton(
                  onPressed: () {
                    controller.toogleSearchBar();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.yellow,
                  ))))
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
