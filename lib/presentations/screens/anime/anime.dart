import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';

import 'package:infinite_wallpapers/presentations/screens/setwallpaper.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  final MyController controller = Get.put(MyController());
  var categorieslist = StaticImagesCategories().animeCatagories;
  @override
  void initState() {
    super.initState();
    controller.animescrollerController
        .addListener(controller.animeloadMorePhotos);
    controller.animefetchInitialPhotos();
  }

  bool searchTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.animescrollerController,
          slivers: [
            AnimeSliverAppBar(
              context,
              controller,
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categorieslist.length,
                      itemBuilder: (context, index) {
                        return animeCatagories(
                          categorieslist[index]['title'].toString(),
                          controller,
                          categorieslist[index]['q'].toString(),
                        );
                      }),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      if (controller.animePhotos.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            childAspectRatio: 0.5,
                            mainAxisSpacing: 4,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.animePhotos.length,
                          itemBuilder: (context, index) {
                            var wallpaper = controller.animePhotos[index];
                            return InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Setwallpaper(
                                    imgUrl: wallpaper.path.toString(),
                                    controller: controller,
                                  ),
                                ),
                              ),
                              child: Container(
                                height: 200,
                                width: 200,
                                margin:
                                    const EdgeInsets.only(left: 2, right: 2),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.yellow, Colors.black]),
                                ),
                                child: Image.network(
                                  wallpaper.thumbs.original.toString(),
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                          child: Text(
                                    'conuld \n not loaded ',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    })),
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.page = 1;
  }
}
