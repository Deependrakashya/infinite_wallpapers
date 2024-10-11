import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';
import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
      body: SafeArea(
        
        child: CustomScrollView(
          slivers: [
             SliverAppBar(
              title: Text('infinite_wallpapers'),
              expandedHeight: 60.0,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    

            ),
            SliverToBoxAdapter(
              
                child: Column(
                  
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                      Categaries(' categaries'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: ClusturedPhotosApiCall(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            child: const Text(' loading data '),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.hasData) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                childAspectRatio: 0.5,
                                      mainAxisSpacing: 10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.photos!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(
                                      color: Colors.red, 
                                      blurRadius: 5,
                                      offset: Offset(2, 0)
                                      // spreadRadius: 30
                                    )],
                                    borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: image(snapshot, index, context));
                              });
                        } else {
                          return Container(
                            child: const Text(' loading data '),
                          );
                        }
                      }),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
