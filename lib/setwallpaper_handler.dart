import 'dart:async';
import 'dart:io';
import 'package:wallpaper/wallpaper.dart';

Future<void> downloadAndSetWallpaper({
  required String imageUrl,
}) async {
  // Start downloading to the Downloads directory
  Stream<String> progressString = Wallpaper.imageDownloadProgress(
    imageUrl,
    location: DownloadLocation
        .externalDirectory, // Save to the public Downloads directory
  );
  print('location ');
  print(DownloadLocation.externalDirectory.toString());
  String downloadedFilePath =
      '/storage/emulated/0/Android/data/infinite_wallpapers.com.infinite_wallpapers/files/myimage.jpeg';

  progressString.listen((data) {
    print("DataReceived: $data");
  }, onDone: () async {
    // Verify if the downloaded file exists
    final file = File(downloadedFilePath);
    if (await file.exists()) {
      print("File found: Setting wallpaper.");
      await Wallpaper
          .homeScreen(); // or Wallpaper.homeScreen(downloadedFilePath)
      print("Wallpaper set successfully!");
    } else {
      print("Error: File not found at $downloadedFilePath");
    }
    print("Task Done");
  }, onError: (error) {
    print("An error occurred during download: $error");
  });
}
