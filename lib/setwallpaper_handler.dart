import 'package:infinite_wallpapers/getx.dart';
import 'package:wallpaper/wallpaper.dart';

Future<void> downloadAndSetWallpaper(
    String imgUrl, MyController controller) async {
  controller.downloading.value = true;
  var progress = await Wallpaper.imageDownloadProgress(imgUrl,
      location: DownloadLocation.temporaryDirectory);
  progress.listen((onData) {
    controller.downloadedData.value = onData;
    print('data $onData');
  }, onDone: () {
    controller.downloading.value = false;
    controller.downloadingDone.value = true;
  });
}

Future<void> setHomeScreen() async {
  await Wallpaper.homeScreen(
      options: RequestSizeOptions.resizeExact,
      location: DownloadLocation.temporaryDirectory);
}

Future<void> setLockScreen() async {
  await Wallpaper.lockScreen(location: DownloadLocation.temporaryDirectory);
}

Future<void> setBothScreen() async {
  await Wallpaper.bothScreen(location: DownloadLocation.temporaryDirectory);
}
