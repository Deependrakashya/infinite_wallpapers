import 'package:wallpaper/wallpaper.dart';

Future<void> downloadAndSetWallpaper(String imgUrl) async {
  var progress = await Wallpaper.imageDownloadProgress(imgUrl,
      location: DownloadLocation.temporaryDirectory);
  progress.listen((onData) {
    print('data $onData');
  }, onDone: () {
    Wallpaper.homeScreen(location: DownloadLocation.temporaryDirectory);
  });
}
