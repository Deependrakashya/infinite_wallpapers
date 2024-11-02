import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class Setwallpaper2 extends StatefulWidget {
  String imgUrl;
  Setwallpaper2(
      {super.key, required this.imgUrl, required BuildContext context});

  @override
  State<Setwallpaper2> createState() => _Setwallpaper2();
}

class _Setwallpaper2 extends State<Setwallpaper2> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  late Stream<String> progressString;
  late String res;
  bool downloading = false;

  var result = "Waiting to set wallpaper";
  bool _isDisable = true;

  int nextImageID = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                downloading
                    ? imageDownloadDialog()
                    : Image.network(
                        widget.imgUrl,
                        fit: BoxFit.fitWidth,
                      ),
                ElevatedButton(
                  onPressed: () async {
                    return await downloadImage(context);
                  },
                  child: const Text("Please download the image"),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          var width = MediaQuery.of(context).size.width;
                          var height = MediaQuery.of(context).size.height;
                          home = await Wallpaper.homeScreen(
                              options: RequestSizeOptions.resizeFit,
                              width: width,
                              location: DownloadLocation.applicationDirectory,
                              height: height);
                          setState(() {
                            downloading = false;
                            home = home;
                          });
                          print("Task Done");
                        },
                  child: Text(home),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          system = await Wallpaper.systemScreen(
                            location: DownloadLocation.applicationDirectory,
                          );
                          setState(() {
                            downloading = false;
                            system = system;
                          });
                          print("Task Done");
                        },
                  child: Text(system),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> downloadImage(BuildContext context) async {
    progressString = Wallpaper.imageDownloadProgress(
      widget.imgUrl,
      location: DownloadLocation.applicationDirectory,
    );
    progressString.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
      print("DataReceived: " + data);
    }, onDone: () async {
      setState(() {
        downloading = false;
        _isDisable = false;
      });
      print("Task Done");
    }, onError: (error) {
      setState(() {
        downloading = false;
        _isDisable = true;
      });
      print("Some Error");
    });
  }

  Widget imageDownloadDialog() {
    return SizedBox(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
