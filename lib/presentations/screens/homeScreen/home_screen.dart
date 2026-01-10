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
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              MySliverAppBar(context, controller),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: categorieslist.length,
                        itemBuilder: (context, index) {
                          return categories(
                            categorieslist[index]['title'].toString(),
                            categorieslist[index]['imgUrl'].toString(),
                            controller,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() {
                      return controller.isLoading.value &&
                              controller.allPhotos.isEmpty
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
                                    child: RepaintBoundary(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: image(
                                            controller
                                                .allPhotos[index].src!.large
                                                .toString(),
                                            index,
                                            context,
                                          ),
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
              Obx(() {
                return controller.isLoading.value &&
                        controller.allPhotos.isNotEmpty
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
        ],
      ),
    );
  }
}
