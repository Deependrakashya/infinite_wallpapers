import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_walls/data/models/wallhaven/wallhaven.dart';
import 'package:zen_walls/data/repositories/wallhaven_repository.dart';

class AnimeViewModel extends GetxController {
  final WallhavenRepository _repository = WallhavenRepository();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<WallhavenData> animePhotos = <WallhavenData>[].obs;
  RxBool isSearchOpen = false.obs;

  int _currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchInitialPhotos();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value) {
      loadMorePhotos();
    }
  }

  void toggleSearch() {
    isSearchOpen.value = !isSearchOpen.value;
    if (!isSearchOpen.value) {
      searchController.clear();
      fetchInitialPhotos();
    }
  }

  Future<void> fetchInitialPhotos() async {
    isLoading.value = true;
    _currentPage = 1;
    try {
      final data = await _repository.fetchPhotos(page: _currentPage.toString());
      if (data.data != null) {
        animePhotos.assignAll(data.data!);
        _currentPage++;
      }
    } catch (e) {
      log('Error fetching initial anime photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchAnime(String query) async {
    isLoading.value = true;
    _currentPage = 1;
    try {
      final data = await _repository.fetchPhotos(
          search: query, page: _currentPage.toString());
      if (data.data != null) {
        animePhotos.assignAll(data.data!);
        _currentPage++;
      }
    } catch (e) {
      log('Error searching anime: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePhotos() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final data = await _repository.fetchPhotos(
        search: isSearchOpen.value ? searchController.text : null,
        page: _currentPage.toString(),
      );

      if (data.data != null) {
        animePhotos.addAll(data.data!);
        _currentPage++;
      }
    } catch (e) {
      log('Error loading more anime photos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
