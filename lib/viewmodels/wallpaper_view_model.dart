import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:zen_walls/services/wallpaper_service.dart';

class WallpaperViewModel extends GetxController {
  RxBool isDownloading = false.obs;
  RxBool isDownloadDone = false.obs;
  RxBool isSettingWallpaper = false.obs;
  RxString downloadStatus = ''.obs;

  void resetState() {
    isDownloading.value = false;
    isDownloadDone.value = false;
    isSettingWallpaper.value = false;
    downloadStatus.value = '';
  }

  Future<void> downloadImage(String imgUrl) async {
    log('downloadImage called for: $imgUrl');
    isDownloading.value = true;
    downloadStatus.value = 'Connecting...';

    try {
      FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(imgUrl);
      if (fileInfo == null) {
        log('Image not in cache, downloading...');
        downloadStatus.value = 'Downloading...';
        fileInfo = await DefaultCacheManager().downloadFile(imgUrl);
      } else {
        log('Image found in cache.');
      }

      log('File ready at: ${fileInfo.file.path}');
      downloadStatus.value = '100%';
      isDownloadDone.value = true;
    } catch (e) {
      log('Download failed with exception: $e');
      downloadStatus.value = 'Error';
    } finally {
      isDownloading.value = false;
    }
  }

  Future<void> applyWallpaper(String imgUrl) async {
    log('applyWallpaper called for: $imgUrl');
    isSettingWallpaper.value = true;
    try {
      bool success = await WallpaperService.setWallpaperFromUrl(
        imgUrl,
      );
      log('Apply Wallpaper Success: $success');
      if (success) {
        isSettingWallpaper.value = false;
      }
    } catch (e) {
      log('Error in applyWallpaper: $e');
      isSettingWallpaper.value = false;
    }
  }
}
