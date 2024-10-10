import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/presentations/screens/splashScreen/splash_screen.dart';


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
      home: const SplashScreen(),
    );
  }
}
