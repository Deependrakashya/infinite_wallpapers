import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:zen_walls/viewmodels/home_view_model.dart';
import 'package:zen_walls/viewmodels/anime_view_model.dart';

SliverAppBar homeSliverAppBar(BuildContext context, HomeViewModel viewModel) {
  return SliverAppBar(
    title: const Text(
      'Infinite Wallpapers',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    floating: true,
    snap: true,
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      Obx(
        () => viewModel.isSearching.value
            ? Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    onSubmitted: (value) => viewModel.searchPhotos(value),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    cursorColor: Colors.purpleAccent,
                    cursorRadius: const Radius.circular(10),
                    cursorWidth: 1,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Search Wallpapers...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(5),
                        onPressed: () => viewModel.resetSearch(),
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.3)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                    ),
                  ),
                ),
              )
            : IconButton(
                onPressed: () => viewModel.isSearching.value = true,
                icon: const Icon(Icons.search, color: Colors.white),
              ),
      ),
    ],
  );
}

SliverAppBar animeSliverAppBar(BuildContext context, AnimeViewModel viewModel) {
  return SliverAppBar(
    title: const Text(
      'Anime Wallpapers',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    floating: true,
    snap: true,
    expandedHeight: 60.0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    actions: [
      Obx(
        () => viewModel.isSearchOpen.value
            ? Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * .95,
                  child: TextField(
                    controller: viewModel.searchController,
                    onSubmitted: (value) => viewModel.searchAnime(value),
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                    cursorColor: Colors.purpleAccent,
                    cursorRadius: const Radius.circular(10),
                    cursorWidth: 1,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Search Anime...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(5),
                        onPressed: () => viewModel.toggleSearch(),
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.3)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.3)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.purpleAccent),
                      ),
                    ),
                  ),
                ),
              )
            : IconButton(
                onPressed: () => viewModel.toggleSearch(),
                icon: const Icon(Icons.search, color: Colors.white),
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
    memCacheHeight: 600,
    memCacheWidth: 400,
    maxWidthDiskCache: 1200,
    maxHeightDiskCache: 1800,
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
