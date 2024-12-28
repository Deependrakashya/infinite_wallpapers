import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/getx.dart';

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
  bool setwallpaperbutton = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.yellow, Colors.black]),
            ),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Center(
                child: const Text(
                  textAlign: TextAlign.center,
                  'Oops ! \n something went wrong !',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              widget.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 40,
              left: 10,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  gradient:
                      LinearGradient(colors: [Colors.yellow, Colors.black]),
                ),
                child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // controller.setWallpaperLoader.value = false;
                    },
                    child: const Icon(
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
                          gradient: const LinearGradient(
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
                          child: const Text(
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.black]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Hold on Dude !! \n Saving Image',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              widget.controller.downloadedData.value.toString(),
                              style: const TextStyle(
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
            print('wallpaper downling  done ' +
                controller.downloadingDone.value.toString());
            return widget.controller.downloadingDone.value
                ? Positioned(
                    bottom: 5,
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(154, 153, 153, 0.494),
                            borderRadius: BorderRadius.circular(10)),
                        child: Obx(() {
                          print(' set wallpaper  ' +
                              controller.setWallpaperLoader.value.toString());

                          return Center(
                              child: setwallpaperbutton
                                  ? Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setHomeScreen();
                                            setState(() {
                                              setwallpaperbutton = false;
                                            });
                                          },
                                          child: customButton(widget.controller,
                                              'set as Home Screen'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setLockScreen();
                                            setState(() {
                                              setwallpaperbutton = false;
                                            });
                                          },
                                          child: customButton(widget.controller,
                                              'set as Lock Screen'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setBothScreen();
                                            setState(() {
                                              setwallpaperbutton = false;
                                            });
                                          },
                                          child: customButton(widget.controller,
                                              'set as Both Screen'),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            'Hold on it may take few seconds',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        const CircularProgressIndicator(
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ));
                        })),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.downloading.value = false;
    widget.controller.downloadingDone.value = false;
    widget.controller.setWallpaperLoader.value = false;
    super.dispose();
  }
}
