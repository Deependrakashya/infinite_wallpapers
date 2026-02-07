import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:zen_walls/data/models/clustered_images/clustered_images.dart';
import 'package:zen_walls/data/repositories/pexels_repository.dart';

class HomeViewModel extends GetxController {
  final PexelsRepository _repository = PexelsRepository();
  final ScrollController scrollController = ScrollController();

  RxBool isLoading = false.obs;
  RxList<Photos> allPhotos = <Photos>[].obs;
  RxBool isBarsVisible = true.obs;
  RxBool isSearching = false.obs;
  RxString searchQuery = ''.obs;

  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchInitialPhotos();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Handle bar visibility
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      isBarsVisible.value = true;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      isBarsVisible.value = false;
    }

    // Handle pagination
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value) {
      loadMorePhotos();
    }
  }

  Future<void> fetchInitialPhotos() async {
    isLoading.value = true;
    _currentPage = 1;
    try {
      final data =
          await _repository.fetchCuratedPhotos(_currentPage.toString());
      if (data.photos != null) {
        allPhotos.assignAll(data.photos!);
        _currentPage++;
      }
    } catch (e) {
      log('Error fetching initial photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchPhotos(String query) async {
    isLoading.value = true;
    isSearching.value = true;
    searchQuery.value = query;
    _currentPage = 1;
    try {
      final data =
          await _repository.searchPhotos(query, _currentPage.toString());
      if (data.photos != null) {
        allPhotos.assignAll(data.photos!);
        _currentPage++;
      }
    } catch (e) {
      log('Error searching photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePhotos() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      ClusteredPhotos data;
      if (isSearching.value) {
        data = await _repository.searchPhotos(
            searchQuery.value, _currentPage.toString());
      } else {
        data = await _repository.fetchCuratedPhotos(_currentPage.toString());
      }

      if (data.photos != null) {
        allPhotos.addAll(data.photos!);
        _currentPage++;
      }
    } catch (e) {
      log('Error loading more photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetSearch() {
    isSearching.value = false;
    searchQuery.value = '';
    fetchInitialPhotos();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
