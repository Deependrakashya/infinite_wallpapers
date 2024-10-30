import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/ApiCall/wallhavenapi.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/screens/setwallpaper.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyController controller = MyController();
  var categorieslist = StaticImagesCategories().catagories;

  bool searchTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MySliverAppBar(context, controller),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  height: 70,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categorieslist.length,
                      itemBuilder: (context, index) {
                        return categories(
                            categorieslist[index]['title'].toString(),
                            categorieslist[index]['imgUrl'].toString());
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: ClusturedPhotosApiCall(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: const Text(' loading data '),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            snapshot.hasData) {
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 0.5,
                                      mainAxisSpacing: 4),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.photos!.length,
                              itemBuilder: (context, index) {
                                print(snapshot.data!.photos![0].alt);
                                return InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Setwallpaper(
                                          imgUrl: snapshot.data!.photos![index]
                                              .src!.portrait
                                              .toString(),
                                        ),
                                      )),
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      decoration: const BoxDecoration(),
                                      child: image(snapshot, index, context)),
                                );
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
