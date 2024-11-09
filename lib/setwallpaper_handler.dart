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
  }, onDone: () {
    controller.downloading.value = false;
    controller.downloadingDone.value = true;
  });
}

Future<void> setHomeScreen() async {
  controller.setWallpaperLoader.value = false;

  var data = await Wallpaper.homeScreen(
      options: RequestSizeOptions.resizeExact,
      location: DownloadLocation.externalDirectory);
  if (data == 'Screen Set Successfully') {
    controller.setWallpaperLoader.value = true;
  }
}

Future<void> setLockScreen() async {
  controller.setWallpaperLoader.value = false;
  // print('lock screen pressed');
  var data =
      await Wallpaper.lockScreen(location: DownloadLocation.externalDirectory);
  if (data == 'Lock Screen Set Successfully') {
    controller.setWallpaperLoader.value = true;
  }
  // print(data);
}

Future<void> setBothScreen() async {
  // print('both screen pressed');

  var data =
      await Wallpaper.bothScreen(location: DownloadLocation.externalDirectory);
  if (data == 'Home and Lock Screen Set Successfully') {
    controller.setWallpaperLoader.value = true;
  }
}
