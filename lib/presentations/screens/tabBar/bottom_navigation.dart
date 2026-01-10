import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:zen_walls/getx.dart';
import 'package:zen_walls/presentations/screens/anime/anime.dart';
import 'package:zen_walls/presentations/screens/homeScreen/home_screen.dart';

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
    final MyController controller = Get.put(MyController(), permanent: true);
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      // Bottom navigation bar
      bottomNavigationBar: Obx(() {
        return SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: controller.isBarsVisible.value ? 40 : 0,
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 39, right: 39),
                  decoration: BoxDecoration(color: Colors.black, boxShadow: [
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
                          tabBackgroundColor:
                              const Color.fromARGB(255, 213, 177, 221),
                          activeColor: const Color.fromARGB(255, 253, 253, 255),
                          color: Colors.black,
                          tabActiveBorder: Border.all(
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          onTabChange: (value) => setIndex(value),
                          rippleColor: const Color.fromARGB(255, 5, 5, 5),
                          gap: 10,
                          tabs: const [
                            GButton(
                              backgroundGradient: LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                              ),
                              icon: Icons.home_outlined,
                              text: 'Home',
                              iconColor: Colors.white,
                            ),
                            GButton(
                              icon: Icons.clear,
                              leading: ImageIcon(
                                AssetImage(
                                    'assets/bottomNavigation/image.png'), // Path to your image
                                size: 24,
                                color: Colors
                                    .white, // Set the size of your custom image icon
                              ),
                              backgroundGradient: LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFFD946EF)],
                              ),
                              text: 'Anime',
                              iconColor: Colors.yellow,
                            )
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
