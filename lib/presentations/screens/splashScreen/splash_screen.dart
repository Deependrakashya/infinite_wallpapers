import 'package:flutter/material.dart';

import 'package:infinite_wallpapers/presentations/screens/tabBar/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNaviagtion()));
    });
  }
}
