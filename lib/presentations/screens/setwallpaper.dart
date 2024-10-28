import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/persmission_hamdler.dart';
import 'package:infinite_wallpapers/setwallpaper_handler.dart';

class Setwallpaper extends StatefulWidget {
  final String imgUrl;
  const Setwallpaper({super.key, required this.imgUrl});

  @override
  State<Setwallpaper> createState() => _SetwallpaperState();
}

class _SetwallpaperState extends State<Setwallpaper> {
  void setwallpaper(String url) async {
    bool getPermissionStatus = await requestPermissions();
    if (!getPermissionStatus) {
      requestPermissions();
      print(getPermissionStatus);

      // go ahead with set wallpaper
    } else {
      print('app has storage access');
      downloadAndSetWallpaper(imageUrl: url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.network(
            height: double.infinity,
            width: double.infinity,
            widget.imgUrl,
            fit: BoxFit.contain,
          ),
          Positioned(
              // left: 10,
              child: IconButton(
                  splashColor: Colors.amber,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Colors.yellow,
                    size: 30,
                  ))),
          Positioned(
              width: MediaQuery.of(context).size.width * 1,
              bottom: 10,
              child: Center(
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    setwallpaper(widget.imgUrl);
                  },
                  child: Text('set Wallpaper'),
                ),
              )),
        ],
      ),
    );
  }
}
