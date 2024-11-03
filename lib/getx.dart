import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';

class MyController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxBool getTouch = false.obs;
  RxBool isLoading = false.obs;
  RxBool downloadingDone = false.obs;
  RxList allPhotos = [].obs;
  RxBool downloading = false.obs;
  RxString downloadedData = ''.obs;

  int page = 1;
  void toggleSearchBar() {
    if (getTouch.value) {
      getTouch.value = false;
      fetchInitialPhotos();
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
        !getTouch.value) {
      // Check if not already loading

      isLoading.value = true; // Set loading flag

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
  }

// search images for pexel
  void searchPexelsImages(String search) async {
    var data = await serachPexelapi(search);
    if (data.photos != null) {
      allPhotos.replaceRange(0, allPhotos.length, data.photos!.toList());

      page++; // Increment page for next load
    }
  }
}
