import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:infinite_wallpapers/presentations/screens/anime/anime.dart';
import 'package:infinite_wallpapers/presentations/screens/homeScreen/home_screen.dart';

class BottomNaviagtion extends StatefulWidget {
  const BottomNaviagtion({super.key});

  @override
  State<BottomNaviagtion> createState() => _HomePageState();
}

class _HomePageState extends State<BottomNaviagtion> {
  int selectedIndex = 0;
  void setIndex(index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const AnimeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[selectedIndex],
        // Bottom navigation bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 39, right: 39),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 67, 1, 99),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: GNav(
                duration: const Duration(milliseconds: 1000),
                tabBackgroundColor: const Color.fromARGB(255, 213, 177, 221),
                activeColor: const Color.fromARGB(255, 253, 253, 255),
                color: Colors.black,
                tabActiveBorder: Border.all(
                  color: Colors.black,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                onTabChange: (value) => setIndex(value),
                rippleColor: const Color.fromARGB(255, 5, 5, 5),
                gap: 10,
                tabs: const [
                  GButton(
                    backgroundGradient: LinearGradient(
                        colors: [Color.fromRGBO(58, 58, 82, 1), Colors.yellow]),
                    icon: Icons.home_outlined,
                    text: 'Home',
                    iconColor: Colors.yellow,
                  ),
                  GButton(
                    icon: Icons.clear,
                    leading: ImageIcon(
                      AssetImage(
                          'assets/bottomNavigation/image.png'), // Path to your image
                      size: 24,
                      color: Colors
                          .yellow, // Set the size of your custom image icon
                    ),
                    backgroundGradient: LinearGradient(
                        colors: [Color.fromRGBO(58, 58, 82, 1), Colors.yellow]),
                    text: 'Anime',
                    iconColor: Colors.yellow,
                  )
                ]),
          )),
        ));
  }
}
