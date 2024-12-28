import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:infinite_wallpapers/presentations/screens/tabBar/bottom_navigation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<InternetStatus> _subscription;
  bool disconnected = false;

  late final AppLifecycleListener _listener;
  @override
  void initState() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      // Handle internet status changes
      if (status.toString() == 'InternetStatus.disconnected') {
        setState(() {
          disconnected = true;
        });
      } else if (status.toString() == 'InternetStatus.connected') {
        setState(() {
          disconnected = false;
          redirect();
        });
      }
      log(status.toString());
    });
    _listener = AppLifecycleListener(
      onResume: _subscription.resume,
      onHide: _subscription.pause,
      onPause: _subscription.pause,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/onboarding/logo_for_infinite_wallpaper_app.png',
                        ),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        // left: MediaQuery.of(context).size.width * .35,
                        top: MediaQuery.of(context).size.height * .16),
                    child: const Text(
                      ' Infinite wallpapers',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ))),
          ),
          disconnected
              ? Positioned(
                  bottom: 20,
                  child: Dialog(
                    backgroundColor: const Color.fromARGB(255, 160, 150, 150)
                        .withOpacity(0.6),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Turn on Internet !!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 0), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNaviagtion()));
    });
  }

  final connection = InternetConnection.createInstance(
    customCheckOptions: [
      InternetCheckOption(
        uri: Uri.parse('https://wallhaven.cc/api/v1/search'),
        responseStatusFn: (response) {
          return response.statusCode >= 69 && response.statusCode < 169;
        },
      ),
      InternetCheckOption(
        uri: Uri.parse('https://wallhaven.cc/api/v1/search'),
        responseStatusFn: (response) {
          return response.statusCode >= 420 && response.statusCode < 1412;
        },
      ),
    ],
  );
}
