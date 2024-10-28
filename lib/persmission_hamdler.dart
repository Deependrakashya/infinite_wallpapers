import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermissions() async {
  if (await Permission.storage.isDenied) {
    PermissionStatus status = await Permission.storage.request();

    if (status.isPermanentlyDenied) {
      // If permission is permanently denied, show a dialog to guide the user to settingsrim
      print(' permission is denied permamentaly');
      return false;
    }
  }
  if (await Permission.storage.request().isGranted) {
    print('app has storage permission');
    return true;
    // You now have access to storage, proceed with downloading or setting wallpaper.
  } else {
    // Handle permission denied case.
    return false;
  }
}
