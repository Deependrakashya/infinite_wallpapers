import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper/wallpaper.dart';

Future<void> downloadAndSetWallpaper({
  required String imageUrl,
}) async {
  String result;
// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await AsyncWallpaper.setWallpaper(
      url: imageUrl,
      wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
      toastDetails: ToastDetails.success(),
      errorToastDetails: ToastDetails.error(),
    )
        ? 'Wallpaper set'
        : 'Failed to get wallpaper.';
  } on PlatformException {
    result = 'Failed to get wallpaper.';
  }
}
