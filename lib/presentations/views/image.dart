import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:zen_walls/getx.dart';

SliverAppBar MySliverAppBar(BuildContext context, MyController controller) {
  TextEditingController textEditingController = TextEditingController();
  return SliverAppBar(
    title: const Text(
      'infinite wallpapers',
      style: TextStyle(color: Colors.white),
    ),
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      Obx(
        () => controller.getTouch.value
            ? Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (value) => controller.searchPexelsImages(
                      textEditingController.text,
                    ),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    cursorColor: Colors.yellow,
                    cursorRadius: const Radius.circular(10),
                    cursorWidth: 1,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Search Here?',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(5),
                        onPressed: () {
                          controller.toggleSearchBar();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                child: IconButton(
                  onPressed: () {
                    controller.toggleSearchBar();
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
      ),
    ],
  );
}

SliverAppBar AnimeSliverAppBar(BuildContext context, MyController controller) {
  controller.page = 1;
  TextEditingController textEditingController =
      controller.textEditingController;
  return SliverAppBar(
    title: const Text(
      'anime wallpapers',
      style: TextStyle(color: Colors.white),
    ),
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      Obx(
        () => controller.getTouch.value
            ? Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (value) => controller.searchAnimePhotos(
                      textEditingController.text,
                    ),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    cursorColor: Colors.white,
                    cursorRadius: const Radius.circular(10),
                    cursorWidth: 1,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Search Here?',
                      hintStyle: const TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(5),
                        onPressed: () {
                          controller.toggleSearchBar();
                          controller.page = 0;
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                child: IconButton(
                  onPressed: () {
                    controller.toggleSearchBar();
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
      ),
    ],
  );
}

Widget image(String url, int index, BuildContext context) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    height: double.infinity,
    placeholder: (context, url) => Shimmer(
      duration: const Duration(seconds: 2),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(color: Colors.grey[900]),
    ),
    errorWidget: (context, url, error) => const Center(
      child: Text(
        'Oops ! \n something went wrong !',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    ),
  );
}
