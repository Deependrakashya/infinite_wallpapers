import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:infinite_wallpapers/presentations/screens/homeScreen/home_screen.dart';
import 'package:infinite_wallpapers/presentations/screens/splashScreen/splash_screen.dart';
import 'package:infinite_wallpapers/presentations/screens/tabBar/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 67, 1, 99),
        useMaterial3: true,
      
      ),
      home: SplashScreen(),
    );
  }
}
