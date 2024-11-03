import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:infinite_wallpapers/persmission_hamdler.dart';
import 'package:infinite_wallpapers/presentations/views/setwallpaper_views.dart';
import 'package:infinite_wallpapers/setwallpaper_handler.dart';
import 'package:get/get.dart';

class Setwallpaper extends StatefulWidget {
  final String imgUrl;
  MyController controller;
  Setwallpaper({super.key, required this.imgUrl, required this.controller});

  @override
  State<Setwallpaper> createState() => _SetwallpaperState();
}

class _SetwallpaperState extends State<Setwallpaper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            height: double.infinity,
            width: double.infinity,
            widget.imgUrl,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 40,
              left: 10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  gradient:
                      LinearGradient(colors: [Colors.yellow, Colors.black]),
                ),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 25,
                    )),
              )),
          Obx(() {
            return widget.controller.downloadingDone.value
                ? Container()
                : Positioned(
                    width: MediaQuery.of(context).size.width * 1,
                    bottom: 10,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.black],
                          ),
                          borderRadius: BorderRadius.circular(
                              12), // Rounded corners for the gradient background
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            downloadAndSetWallpaper(
                                widget.imgUrl, widget.controller);
                          },
                          child: Text(
                            'set Wallpaper',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ));
          }),
          Obx(() {
            return widget.controller.downloading.value
                ? Center(
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.black]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Hold on Dude !! \n Saving Image',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              widget.controller.downloadedData.value.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          }),
          Obx(() {
            return widget.controller.downloadingDone.value
                ? Positioned(
                    bottom: 5,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(154, 153, 153, 0.494),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          customButton(widget.controller, setHomeScreen(),
                              'set as Home Screen'),
                          customButton(widget.controller, setLockScreen(),
                              'set as Lock Screen'),
                          customButton(widget.controller, setBothScreen(),
                              'set as Both Screen'),
                        ],
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.downloading;
    widget.controller.downloadingDone.value = false;
  }
}
