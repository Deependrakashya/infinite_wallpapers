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
    controller.checkInternet();
    controller.animescrollerController
        .addListener(controller.animeloadMorePhotos);
    controller.animefetchInitialPhotos();
    controller.setWallpaperLoader.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    controller.page = 1;
  }

  bool searchTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
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
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Obx(() {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                        })),
                    Obx(() {
                      return !controller.animePageisLoading.value ||
                              controller.animePhotos.length < 1
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: GridView.builder(
                                itemCount: 20,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1,
                                  childAspectRatio: 0.4,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    color: const Color.fromARGB(
                                        255, 227, 226, 226),
                                  );
                                },
                              ),
                            )
                          : Container();
                    })
                  ],
                ))
              ],
            ),
            // Obx(() {
            //   return controller.disconnected.value
            //       ? Container(
            //           color: const Color.fromARGB(255, 30, 29, 29)
            //               .withOpacity(0.7),
            //           height: MediaQuery.of(context).size.height * 1,
            //           width: MediaQuery.of(context).size.width * 1,
            //           child: Center(
            //             child: Container(
            //               height: 200,
            //               width: 200,
            //               decoration: BoxDecoration(
            //                   color: Colors.red,
            //                   borderRadius: BorderRadius.circular(20)),
            //               child: Column(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(top: 20),
            //                     child: Center(
            //                       child: Text(
            //                         "Please turn on \n internet",
            //                         textAlign: TextAlign.center,
            //                         style: TextStyle(
            //                             color: Colors.white, fontSize: 20),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 20,
            //                   ),
            //                   CircularProgressIndicator(
            //                     color: Colors.yellow,
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //         )
            //       : Container(
            //           width: 0,
            //           height: 0,
            //         );
            // })
          ],
        ),
      ),
    );
  }
}
