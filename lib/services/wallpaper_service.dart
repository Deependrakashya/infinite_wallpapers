import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:developer' as dev;

class WallpaperService {
  static const MethodChannel _channel =
      MethodChannel('com.devquorix.zenwalls/wallpaper');

  /// Launches the native filtered system "Set as" chooser for the image at [url].
  /// This downloads the image, saves it to a temporary directory, and then
  /// invokes the native method to show the chooser.
  static Future<bool> setWallpaperFromUrl(String url) async {
    dev.log('setWallpaperFromUrl triggered for url: $url',
        name: 'WallpaperService');
    try {
      dev.log('Starting file download...', name: 'WallpaperService');
      final file = await DefaultCacheManager().getSingleFile(url);
      dev.log('Download complete. File path: ${file.path}',
          name: 'WallpaperService');

      // Create a temporary file in a location shareable by FileProvider
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last.split('?').first;
      final tempFile = File('${tempDir.path}/$fileName');

      // Copy the cached file to the temp location
      await file.copy(tempFile.path);
      dev.log('File copied to temp location: ${tempFile.path}',
          name: 'WallpaperService');

      final contentUri =
          'content://com.devquorix.zenwalls.fileprovider/my_cache/$fileName';

      dev.log('Invoking native showWallpaperChooser with URI: $contentUri',
          name: 'WallpaperService');

      await _channel.invokeMethod('showWallpaperChooser', {'uri': contentUri});

      return true;
    } catch (e) {
      dev.log('Error in setWallpaperFromUrl: $e',
          name: 'WallpaperService', error: e);
      return false;
    }
  }
}
