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
      body: Container(
        child: Center(
          child: Text('SplashScreen Screen'),
        ),
      ),
    );
  }
  Future<void>redirect() async{
  await  Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNaviagtion()));
    });
  }
}