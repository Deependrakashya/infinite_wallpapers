import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';
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

  @override
  void initState() {
    super.initState();
    controller.scrollController.addListener(controller.loadMorePhotos);
    controller.fetchInitialPhotos(); // Fetch initial photos
  }

  var categorieslist = StaticImagesCategories().catagories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            MySliverAppBar(context, controller),
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
                      itemCount: controller.allPhotos.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Setwallpaper(
                                imgUrl: controller
                                    .allPhotos[index].src!.original
                                    .toString(),
                                controller: controller,
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 2, right: 2),
                            decoration: const BoxDecoration(),
                            child: image(
                              controller.allPhotos[index].src!.large.toString(),
                              index,
                              context,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    return controller.isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : Container();
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
