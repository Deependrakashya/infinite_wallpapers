// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_wallpapers/presentations/screens/splashScreen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.lobsterTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
            displayMedium: TextStyle(
          color: Colors.black,
        )),
        colorSchemeSeed: const Color.fromARGB(255, 83, 52, 99),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
