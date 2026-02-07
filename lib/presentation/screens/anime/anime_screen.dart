import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:zen_walls/services/const.dart';
import 'package:zen_walls/viewmodels/anime_view_model.dart';
import 'package:zen_walls/presentation/screens/set_wallpaper_screen.dart';
import 'package:zen_walls/presentation/widgets/categories.dart';
import 'package:zen_walls/presentation/widgets/image_widget.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen>
    with AutomaticKeepAliveClientMixin {
  final AnimeViewModel animeViewModel = Get.put(AnimeViewModel());
  var categorieslist = StaticImagesCategories().animeCatagories;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: animeViewModel.scrollController,
            slivers: [
              animeSliverAppBar(context, animeViewModel),
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                collapsedHeight: 60,
                expandedHeight: 60,
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    height: 60,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: categorieslist.length,
                        itemBuilder: (context, index) {
                          return animeCategory(
                            categorieslist[index]['title'].toString(),
                            animeViewModel,
                            categorieslist[index]['q'].toString(),
                          );
                        }),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() {
                  final theme = Theme.of(context);
                  return animeViewModel.isLoading.value &&
                          animeViewModel.animePhotos.isEmpty
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
                            itemCount: animeViewModel.animePhotos.length,
                            itemBuilder: (context, index) {
                              var wallpaper = animeViewModel.animePhotos[index];
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => Setwallpaper(
                                      imgUrl: wallpaper.path.toString(),
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
                                      wallpaper.thumbs?.original.toString() ??
                                          '',
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
              ),
              Obx(() {
                return animeViewModel.isLoading.value &&
                        animeViewModel.animePhotos.isNotEmpty
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
