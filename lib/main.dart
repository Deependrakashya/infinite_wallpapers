// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zen_walls/presentations/screens/splashScreen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // ... inside your main or a suitable initialization point
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
    systemNavigationBarColor: Colors.transparent, // Transparent navigation bar
    // Optionally, adjust icon colors for visibility
    statusBarIconBrightness: Brightness.dark, // For light background
    systemNavigationBarIconBrightness: Brightness.dark, // For light background
  ));
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
        scaffoldBackgroundColor: Colors.black,
        primaryTextTheme: TextTheme(
            displayMedium: TextStyle(
          color: Colors.white,
        )),
        colorSchemeSeed: const Color.fromARGB(255, 83, 52, 99),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
