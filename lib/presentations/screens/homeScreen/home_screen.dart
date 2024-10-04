import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('infinite_wallpapers'),
                      expandedHeight: 100.0,

        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
              Container(height: 200,color: Colors.yellow,margin: EdgeInsets.all(10),),
            ],
          ),
        )
      ],
    ),

      
    
    
    );

  }
}
