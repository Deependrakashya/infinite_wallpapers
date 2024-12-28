import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:infinite_wallpapers/presentations/screens/setwallpaper.dart';

import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyController controller = MyController();

  @override
  void initState() {
    super.initState();
    controller.checkInternet();
    controller.scrollController.addListener(controller.loadMorePhotos);
    controller.fetchInitialPhotos(); // Fetch initial photos
  }

  var categorieslist = StaticImagesCategories().catagories;

  @override
  Widget build(BuildContext context) {
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
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
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
                            itemCount: controller.allPhotos.length ??= 10,
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
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 2),
                                  decoration: const BoxDecoration(),
                                  child: image(
                                    controller.allPhotos[index].src!.large
                                        .toString(),
                                    index,
                                    context,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      Obx(() {
                        return !controller.isLoading.value ||
                                controller.allPhotos.length < 1
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
                      }),

                      // disconnected
                      //     ? Dialog(
                      //         child: Container(
                      //           height: 200,
                      //           width: 200,
                      //           color: Colors.red,
                      //           child: Center(
                      //             child: Text('please turn on internet'),
                      //           ),
                      //         ),
                      //       )
                      //     : Container()
                    ],
                  ),
                ),
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
