import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/presentations/screens/home_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
    colorSchemeSeed: const Color.fromARGB(255, 67, 1, 99),
              useMaterial3: true,
              
              ),
              home:const HomePage() ,
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex=0;

  final List<Widget>screens=[
const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screens[selectedIndex] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: const [
           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
           BottomNavigationBarItem(icon: Icon(Icons.image_search_outlined), label: 'search'),
        
      ]),
    );
  }
}