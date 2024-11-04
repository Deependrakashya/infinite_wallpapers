import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/ApiCall/wallhavenapi.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/model/wellhaven/wellhaven.dart';

class MyController extends GetxController {
  ScrollController scrollController = ScrollController();
  ScrollController animescrollerController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  RxBool getTouch = false.obs;
  RxBool isLoading = false.obs;
  RxBool animePageisLoading = false.obs;
  RxBool downloadingDone = false.obs;
  RxList allPhotos = [].obs;
  RxBool downloading = false.obs;
  RxString downloadedData = ''.obs;
  RxString catagoriesSearch = ''.obs;
  RxBool categoriesTapped = false.obs;
  RxList animePhotos = [].obs;

  int page = 1;
  void toggleSearchBar() {
    if (getTouch.value) {
      getTouch.value = false;
      fetchInitialPhotos();
      searchAnimePhotos('anime');
    } else {
      getTouch.value = true;
    }
  }

// function for fetching data
  Future<void> fetchInitialPhotos() async {
    isLoading.value = true; // Set loading flag
    try {
      ClusturedPhotos data = await ClusturedPhotosApiCall(page.toString());
      if (data.photos != null) {
        allPhotos.replaceRange(
            0, allPhotos.length, data.photos!.toList()); // Add initial photos
        page++; // Increment page for next load
      }
    } catch (error) {
      print('Error fetching initial photos: $error');
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
        ClusturedPhotos data = await ClusturedPhotosApiCall(page.toString());
        if (data.photos != null) {
          allPhotos.addAll(data.photos!); // Add photos from the response
          page++; // Increment page for next load
        }
      } catch (error) {
        print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        categoriesTapped.value) {
      try {
        var data =
            await serachPexelapi(catagoriesSearch.value, page.toString());
        if (data.photos != null) {
          allPhotos.addAll(data.photos!); // Add photos from the response
          page++; // Increment page for next load
        }
      } catch (error) {
        print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
  }

// search images for pexel
  void searchPexelsImages(String search) async {
    categoriesTapped.value = true;
    catagoriesSearch.value = search;
    var data = await serachPexelapi(search, '1');
    if (data.photos != null) {
      allPhotos.replaceRange(0, allPhotos.length, data.photos!.toList());

      page++; // Increment page for next load
    }
  }

// _+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // ANIME STUFF
  Future<void> animefetchInitialPhotos() async {
    print('anime wallheave initial api called');
    animePageisLoading.value = true; // Set loading flag
    try {
      var data = await WallheavenApiCall();
      if (data.data != null) {
        animePhotos.addAll(data.data!.toList());
        page++; // Increment page for next load
      }
    } catch (error) {
      print('Error fetching initial photos: $error');
    } finally {
      animePageisLoading.value = false; // Reset loading flag
    }
  }

  Future<void> searchAnimePhotos(
    String search,
  ) async {
    animePageisLoading.value = true;
    try {
      var data = await WallheavenApiCall(
        path: search,
      );
      if (data.data != null) {
        print(data.data![0].toString());
        animePhotos.replaceRange(0, animePhotos.length, data.data!.toList());
      }
    } catch (e) {
      print('Error fetching initial photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void animeloadMorePhotos() async {
    if (animescrollerController.position.pixels ==
        animescrollerController.position.maxScrollExtent) {
      // Check if not already loading

      // Set loading flag
// laoding more images for clustured or defult homescreen
      try {
        var data = await WallheavenApiCall(page: page.toString());

        if (data.data != null) {
          animePhotos
              .addAll(data.data!.toList()); // Add photos from the response
          print('page $page');
          page++; // Increment page for next load
        }
      } catch (error) {
        print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        getTouch.value) {
      try {
        var data = await WallheavenApiCall(
            search: textEditingController.text, page: page.toString());
        if (data.data != null) {
          allPhotos.addAll(data.data!.toList()); // Add photos from the response
          page++; // Increment page for next load
        }
      } catch (error) {
        print('Error loading more photos: $error');
      } finally {
        isLoading.value = false; // Reset loading flag
      }
    }
  }
}
