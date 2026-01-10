import 'dart:developer';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:zen_walls/getx.dart';
import 'package:zen_walls/services/wallpaper_service.dart';

final MyController controller = Get.find<MyController>();

Future<void> downloadAndSetWallpaper(
  String imgUrl,
  MyController controller,
) async {
  log('downloadAndSetWallpaper called for: $imgUrl');
  controller.downloading.value = true;
  controller.downloadedData.value = 'Connecting...';

  try {
    FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(imgUrl);
    if (fileInfo == null) {
      log('Image not in cache, downloading...');
      controller.downloadedData.value = 'Downloading...';
      fileInfo = await DefaultCacheManager().downloadFile(imgUrl);
    } else {
      log('Image found in cache.');
    }

    if (fileInfo != null) {
      log('File ready at: ${fileInfo.file.path}');
      controller.downloadedData.value = '100%';
      controller.downloadingDone.value = true;
    } else {
      log('File info is null after download Attempt.');
      controller.downloadedData.value = 'Failed';
    }
  } catch (e) {
    log('Download failed with exception: $e');
    controller.downloadedData.value = 'Error';
  } finally {
    controller.downloading.value = false;
  }
}

Future<void> setHomeScreen(String imgUrl) async {
  log('UI Action: Set Home Screen for $imgUrl');
  try {
    bool success = await WallpaperService.setWallpaperFromUrl(
      imgUrl,
      WallpaperLocation.home,
    );
    log('Set Home Screen Success: $success');
    if (success) {
      controller.setWallpaperLoader.value = false;
    }
  } catch (e) {
    log('Error in setHomeScreen handler: $e');
  }
}

Future<void> setLockScreen(String imgUrl) async {
  log('UI Action: Set Lock Screen for $imgUrl');
  try {
    bool success = await WallpaperService.setWallpaperFromUrl(
      imgUrl,
      WallpaperLocation.lock,
    );
    log('Set Lock Screen Success: $success');
    if (success) {
      controller.setWallpaperLoader.value = false;
    }
  } catch (e) {
    log('Error in setLockScreen handler: $e');
  }
}

Future<void> setBothScreen(String imgUrl) async {
  log('UI Action: Set Both Screens for $imgUrl');
  try {
    bool success = await WallpaperService.setWallpaperFromUrl(
      imgUrl,
      WallpaperLocation.both,
    );
    log('Set Both Screens Success: $success');
    if (success) {
      controller.setWallpaperLoader.value = false;
    }
  } catch (e) {
    log('Error in setBothScreen handler: $e');
  }
}
