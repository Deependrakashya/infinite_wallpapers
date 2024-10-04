
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[selectedIndex],
        // Bottom navigation bar 
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 39, right: 39),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(0.1))
          ]),
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: GNav(
                duration: Duration(milliseconds: 1000),
                tabBackgroundColor: const Color.fromARGB(255, 213, 177, 221)!,
                activeColor: const Color.fromARGB(255, 0, 4, 12),
                color: Colors.black,
                tabActiveBorder: Border.all(
                  color: Colors.black,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                onTabChange: (value) => setIndex(value),
                rippleColor: const Color.fromARGB(255, 5, 5, 5),
                gap: 10,
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'home',
                  ),
                  GButton(
                    icon: Icons.star_border_purple500_outlined,
                    text: 'favourite',
                  )
                ]),
          )),
        ));
  }
}
