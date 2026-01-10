import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:zen_walls/services/const.dart';
import 'package:zen_walls/getx.dart';

import 'package:zen_walls/presentations/screens/setwallpaper.dart';
import 'package:zen_walls/presentations/views/categaries.dart';

import 'package:zen_walls/presentations/views/image.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen>
    with AutomaticKeepAliveClientMixin {
  final MyController controller = Get.put(MyController());
  var categorieslist = StaticImagesCategories().animeCatagories;
  @override
  void initState() {
    super.initState();
    controller.checkInternet();
    controller.animescrollerController
        .addListener(controller.animeloadMorePhotos);
    if (controller.animePhotos.isEmpty) {
      controller.animefetchInitialPhotos();
    }
    controller.setWallpaperLoader.value = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool searchTap = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
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
                    height: 60,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: categorieslist.length,
                        itemBuilder: (context, index) {
                          return animeCatagories(
                            categorieslist[index]['title'].toString(),
                            controller,
                            categorieslist[index]['q'].toString(),
                          );
                        }),
                  ),
                  Obx(() {
                    final theme = Theme.of(context);
                    return controller.animePageisLoading.value &&
                            controller.animePhotos.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(12),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.6,
                                mainAxisSpacing: 12,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Shimmer(
                                  duration: const Duration(seconds: 2),
                                  color: Colors.white,
                                  colorOpacity: 0.1,
                                  enabled: true,
                                  direction: ShimmerDirection.fromLTRB(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.6,
                                mainAxisSpacing: 12,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.animePhotos.length,
                              itemBuilder: (context, index) {
                                var wallpaper = controller.animePhotos[index];
                                return InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => Setwallpaper(
                                        imgUrl: wallpaper.path.toString(),
                                        controller: controller,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                            0.3,
                                          ),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: image(
                                        wallpaper.thumbs.original.toString(),
                                        index,
                                        context,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }),
                ],
              )),
              Obx(() {
                return controller.animePageisLoading.value &&
                        controller.animePhotos.isNotEmpty
                    ? SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: SizedBox(height: 10));
              }),
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
    );
  }
}
