import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:zen_walls/services/const.dart';
import 'package:zen_walls/getx.dart';
import 'package:zen_walls/presentations/screens/setwallpaper.dart';

import 'package:zen_walls/presentations/views/categaries.dart';

import 'package:zen_walls/presentations/views/image.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final MyController controller = Get.put(MyController(), permanent: true);

  @override
  void initState() {
    super.initState();
    controller.checkInternet();
    controller.scrollController.addListener(controller.loadMorePhotos);
    if (controller.allPhotos.isEmpty) {
      controller.fetchInitialPhotos(); // Fetch initial photos
    }
  }

  @override
  bool get wantKeepAlive => true;
  var categorieslist = StaticImagesCategories().catagories;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                MySliverAppBar(
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
                            return categories(
                                categorieslist[index]['title'].toString(),
                                categorieslist[index]['imgUrl'].toString(),
                                controller);
                          },
                        ),
                      ),
                      Obx(() {
                        return controller.isLoading.value
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1,
                                    childAspectRatio: 0.5,
                                    mainAxisSpacing: 4,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.all(2),
                                      child: Shimmer(
                                        duration: const Duration(
                                            seconds:
                                                2), // smoother, noticeable animation
                                        interval: const Duration(
                                            milliseconds:
                                                500), // time between shimmer cycles
                                        color: Colors.white,
                                        colorOpacity: 0.4,
                                        enabled: true,
                                        direction:
                                            ShimmerDirection.fromLeftToRight(),
                                        child: Container(
                                          height:
                                              150, // give some height to see the shimmer
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 88, 88, 90),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 0.5,
                                    mainAxisSpacing: 8,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.allPhotos.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => Setwallpaper(
                                            imgUrl: controller
                                                .allPhotos[index].src!.original
                                                .toString(),
                                            controller: controller,
                                          ),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.4), // shadow color
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                                offset: const Offset(
                                                    4, 4), // x, y offset
                                              ),
                                              BoxShadow(
                                                color: Colors.white.withOpacity(
                                                    0.1), // subtle highlight for 3D
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(-2, -2),
                                              ),
                                            ],
                                          ),
                                          child: image(
                                            controller
                                                .allPhotos[index].src!.large
                                                .toString(),
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
