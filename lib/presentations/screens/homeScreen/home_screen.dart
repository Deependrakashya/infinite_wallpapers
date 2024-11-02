import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/ApiCall/wallhavenapi.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/screens/setwallpaper.dart';
import 'package:infinite_wallpapers/presentations/screens/setwallpaper2.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  List<Photos> allPhotos = [];
  int page = 1; // Start from page 1
  bool isLoading = false; // Flag to prevent multiple calls

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_loadMorePhotos);
    _fetchInitialPhotos(); // Fetch initial photos
  }

  Future<void> _fetchInitialPhotos() async {
    setState(() {
      isLoading = true; // Set loading flag
    });
    try {
      ClusturedPhotos data = await ClusturedPhotosApiCall(page.toString());
      if (data.photos != null) {
        setState(() {
          allPhotos.addAll(data.photos!); // Add initial photos
          page++; // Increment page for next load
        });
      }
    } catch (error) {
      print('Error fetching initial photos: $error');
    } finally {
      setState(() {
        isLoading = false; // Reset loading flag
      });
    }
  }

  void _loadMorePhotos() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoading) {
      // Check if not already loading
      setState(() {
        isLoading = true; // Set loading flag
      });
      try {
        ClusturedPhotos data = await ClusturedPhotosApiCall(page.toString());
        if (data.photos != null) {
          setState(() {
            allPhotos.addAll(data.photos!); // Add photos from the response
            page++; // Increment page for next load
          });
        }
      } catch (error) {
        print('Error loading more photos: $error');
      } finally {
        setState(() {
          isLoading = false; // Reset loading flag
        });
      }
    }
  }

  MyController controller = MyController();
  var categorieslist = StaticImagesCategories().catagories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scrollController,
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
                        );
                      },
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 4,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allPhotos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setwallpaper(
                              imgUrl: allPhotos[index].src!.medium.toString(),
                            ),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          decoration: const BoxDecoration(),
                          child: image(
                            allPhotos[index].src!.medium.toString(),
                            index,
                            context,
                          ),
                        ),
                      );
                    },
                  ),
                  if (isLoading) // Show loading indicator
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
