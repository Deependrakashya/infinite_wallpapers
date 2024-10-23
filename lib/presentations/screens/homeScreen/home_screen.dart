import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searchTap = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MySliverAppBar(context, searchTap, (bool newSearchTap) {
              setState(() {
                searchTap = newSearchTap;
              });
            }),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      categories(' Ocean', StaticImagesCategories.ocean),
                      categories(' Nature', StaticImagesCategories.nature),
                      categories(
                          ' Cityscapes', StaticImagesCategories.citySpace),
                      categories(' Animals', StaticImagesCategories.animal),
                      categories(' Technology', StaticImagesCategories.tech),
                      categories(' Space', StaticImagesCategories.space),
                      categories(
                          ' Minimalist', StaticImagesCategories.minumlistic),
                      categories(' Sports', StaticImagesCategories.sports),
                      categories(' Fantasy', StaticImagesCategories.fantasy),
                      categories(' Food & Drink', StaticImagesCategories.foods),
                      categories(' Art & Design', StaticImagesCategories.art),
                      categories(' Flowers', StaticImagesCategories.flowers),
                      categories(' Seasons', StaticImagesCategories.sesons),
                    ],
                  ),
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
                                return Container(
                                    padding: const EdgeInsets.only(
                                        left: 2, right: 2),
                                    decoration: const BoxDecoration(),
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
