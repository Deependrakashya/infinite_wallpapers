import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:wallpaper/wallpaper.dart';

final MyController controller = Get.put(MyController());

Future<void> downloadAndSetWallpaper(
    String imgUrl, MyController controller) async {
  controller.downloading.value = true;
  var progress = await Wallpaper.imageDownloadProgress(imgUrl,
      location: DownloadLocation.externalDirectory);
  progress.listen((onData) {
    controller.downloadedData.value = onData;
    // print('data $onData');
    if (controller.downloadedData.value.toString() == '100%') {
      controller.downloadingDone.value = true;
      controller.setWallpaperLoader.value = false;
    }
  }, onDone: () {
    log('image saved Successfully');

    controller.downloading.value = false;
    controller.downloadingDone.value = true;
  });
}

Future<void> setHomeScreen() async {
  var data = await Wallpaper.homeScreen(
      options: RequestSizeOptions.resizeExact,
      location: DownloadLocation.externalDirectory);
  if (data == 'Screen Set Successfully') {
    controller.setWallpaperLoader.value = false;
  }
}

Future<void> setLockScreen() async {
  // controller.setWallpaperLoader.value = false;
  // print('lock screen pressed');

  Wallpaper.homeScreen(
    options: RequestSizeOptions.resizeFit,
  );
  // var data =
  //     await Wallpaper.lockScreen(location: DownloadLocation.externalDirectory);
  // if (data == 'Lock Screen Set Successfully') {
  //   controller.setWallpaperLoader.value = false;
  // }
  // print(data);
}

Future<void> setBothScreen() async {
  // print('both screen pressed');

  var data =
      await Wallpaper.bothScreen(location: DownloadLocation.externalDirectory);
  if (data == 'Home and Lock Screen Set Successfully') {
    controller.setWallpaperLoader.value = false;
  }
}
