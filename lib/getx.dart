import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zen_walls/viewmodel/ApiCall/clustured_api.dart';
import 'package:zen_walls/viewmodel/ApiCall/wallhavenapi.dart';
import 'package:zen_walls/model/clusturedImages/clusturedImages.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MyController extends GetxController {
  ScrollController scrollController = ScrollController();
  ScrollController animescrollerController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  late final StreamSubscription<InternetStatus> _subscription;

  RxBool getTouch = false.obs;
  RxBool isLoading = false.obs;
  RxBool disconnected = false.obs;
  RxBool animePageisLoading = false.obs;
  RxBool downloadingDone = false.obs;
  RxList allPhotos = [].obs;
  RxBool downloading = false.obs;
  RxString downloadedData = ''.obs;
  RxString catagoriesSearch = ''.obs;
  RxBool categoriesTapped = false.obs;
  RxBool isBarsVisible = true.obs;
  RxList animePhotos = [].obs;
  RxBool setWallpaperLoader = false.obs;

  int pexelsPage = 1;
  int animePage = 1;
  // check internet connection
  void checkInternet() async {
    log('check intenet');

    bool result = await InternetConnection().hasInternetAccess;

    final listener =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          // The internet is now connected
          log('sconnected');
          disconnected.value = false;

          break;
        case InternetStatus.disconnected:
          // The internet is now disconnected
          log('disconnected');
          disconnected.value = true;

          break;
      }
    });
  }

  void toggleSearchBar() {
    if (getTouch.value) {
      getTouch.value = false;
      fetchInitialPhotos();
      searchAnimePhotos('anime');
    } else {
      getTouch.value = true;
    }
  }

  void updateScrollDirection(ScrollDirection direction) {
    if (direction == ScrollDirection.forward) {
      isBarsVisible.value = true;
    } else if (direction == ScrollDirection.reverse) {
      isBarsVisible.value = false;
    }
  }

// function for fetching data
  Future<void> fetchInitialPhotos() async {
    isLoading.value = true; // Set loading flag
    pexelsPage = 1;
    log("fetching photos ");
    try {
      ClusturedPhotos data =
          await ClusturedPhotosApiCall(pexelsPage.toString());
      if (data.photos != null) {
        allPhotos.replaceRange(
            0, allPhotos.length, data.photos!.toList()); // Add initial photos
        pexelsPage++; // Increment page for next load
      }
    } catch (error) {
      // print('Error fetching initial photos: $error');
    } finally {
      isLoading.value = false; // Reset loading flag
    }
  }

// fetching photos for infinite scrolling
  void loadMorePhotos() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value &&
        !getTouch.value &&
        !categoriesTapped.value) {
      // Check if not already loading

      isLoading.value = true; // Set loading flag
// laoding more images for clustured or defult homescreen
      try {
        ClusturedPhotos data =
            await ClusturedPhotosApiCall(pexelsPage.toString());
        if (data.photos != null) {
          allPhotos.addAll(data.photos!); // Add photos from the response
          pexelsPage++; // Increment page for next load
        }
      } catch (error) {
        // print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading.value &&
        categoriesTapped.value) {
      isLoading.value = true;
      try {
        var data =
            await serachPexelapi(catagoriesSearch.value, pexelsPage.toString());
        if (data.photos != null) {
          allPhotos.addAll(data.photos!); // Add photos from the response
          pexelsPage++; // Increment page for next load
        }
      } catch (error) {
        // print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
  }

// search images for pexel
  void searchPexelsImages(String search) async {
    categoriesTapped.value = true;
    catagoriesSearch.value = search;
    pexelsPage = 1;
    var data = await serachPexelapi(search, '1');
    if (data.photos != null) {
      allPhotos.replaceRange(0, allPhotos.length, data.photos!.toList());

      pexelsPage++; // Increment page for next load
    }
  }

// _+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // ANIME STUFF
  Future<void> animefetchInitialPhotos() async {
    // print('anime wallheave initial api called');
    animePageisLoading.value = true; // Set loading flag
    animePage = 1;
    try {
      var data = await WallheavenApiCall();
      if (data.data != null) {
        animePhotos.replaceRange(0, animePhotos.length, data.data!.toList());
        animePage++; // Increment page for next load
      }
    } catch (error) {
      // print('Error fetching initial photos: $error');
    } finally {
      animePageisLoading.value = false; // Reset loading flag
    }
  }

  Future<void> searchAnimePhotos(
    String search,
  ) async {
    animePageisLoading.value = true;
    animePage = 1;
    try {
      var data = await WallheavenApiCall(
        search: search,
      );
      if (data.data != null) {
        animePhotos.replaceRange(0, animePhotos.length, data.data!.toList());
        animePage++;
      }
    } catch (e) {
      // print('Error fetching initial photos: $e');
    } finally {
      animePageisLoading.value = false;
    }
  }

  void animeloadMorePhotos() async {
    if (animescrollerController.position.pixels ==
            animescrollerController.position.maxScrollExtent &&
        !animePageisLoading.value &&
        !getTouch.value) {
      // Check if not already loading
      // print('search bar is closed');
      // Set loading flag
      animePageisLoading.value = true;
// laoding more images for clustured or defult homescreen
      try {
        // print(animePage.toString() + 'laoding more');
        var data = await WallheavenApiCall(page: animePage.toString());

        if (data.data != null) {
          animePhotos
              .addAll(data.data!.toList()); // Add photos from the response
          // print('page $animePage');
          animePage++; // Increment page for next load
        }
      } catch (error) {
        // print('Error loading more photos: $error');
      } finally {
        animePageisLoading.value = false; // Reset loading flag
      }
    }
    if (animescrollerController.position.pixels ==
            animescrollerController.position.maxScrollExtent &&
        !animePageisLoading.value &&
        getTouch.value) {
      // print('search bar is open $animePage');
      animePageisLoading.value = true;
      try {
        var data = await WallheavenApiCall(
            search: textEditingController.text, page: animePage.toString());
        if (data.data != null) {
          animePhotos
              .addAll(data.data!.toList()); // Add photos from the response
          animePage++; // Increment page for next load
        }
      } catch (error) {
        // print('Error loading more photos: $error');
      } finally {
        animePageisLoading.value = false; // Reset loading flag
      }
    }
  }
}
