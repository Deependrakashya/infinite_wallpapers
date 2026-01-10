import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:developer' as dev;

enum WallpaperLocation { home, lock, both }

class WallpaperService {
  static const MethodChannel _channel = MethodChannel('com.vaky.aio/wallpaper');

  /// Sets the wallpaper from a local file path.
  /// [path] Absolute path to the image file.
  /// [location] Where to set the wallpaper (home, lock, or both).
  static Future<bool> setWallpaper(
      String path, WallpaperLocation location) async {
    dev.log('setWallpaper triggered for path: $path, location: $location',
        name: 'WallpaperService');
    try {
      final int locationInt;
      switch (location) {
        case WallpaperLocation.home:
          locationInt = 1;
          break;
        case WallpaperLocation.lock:
          locationInt = 2;
          break;
        case WallpaperLocation.both:
          locationInt = 3;
          break;
      }

      dev.log('Invoking MethodChannel with locationInt: $locationInt',
          name: 'WallpaperService');
      final bool? result = await _channel.invokeMethod('setWallpaper', {
        'path': path,
        'location': locationInt,
      });
      dev.log('MethodChannel result: $result', name: 'WallpaperService');
      return result ?? false;
    } on PlatformException catch (e) {
      dev.log('PlatformException: ${e.message}',
          name: 'WallpaperService', error: e);
      return false;
    } catch (e) {
      dev.log('Unexpected error: $e', name: 'WallpaperService', error: e);
      return false;
    }
  }

  /// Downloads an image from [url] using [DefaultCacheManager] and sets it as wallpaper.
  static Future<bool> setWallpaperFromUrl(
      String url, WallpaperLocation location) async {
    dev.log('setWallpaperFromUrl triggered for url: $url',
        name: 'WallpaperService');
    try {
      dev.log('Starting file download...', name: 'WallpaperService');
      final file = await DefaultCacheManager().getSingleFile(url);
      dev.log('Download complete. File path: ${file.path}',
          name: 'WallpaperService');
      return await setWallpaper(file.path, location);
    } catch (e) {
      dev.log('Error in setWallpaperFromUrl: $e',
          name: 'WallpaperService', error: e);
      return false;
    }
  }
}
