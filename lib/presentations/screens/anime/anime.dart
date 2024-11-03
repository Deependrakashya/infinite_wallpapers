import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/const.dart';
import 'package:infinite_wallpapers/getx.dart';

import 'package:infinite_wallpapers/model/ApiCall/wallhavenapi.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/screens/setwallpaper.dart';
import 'package:infinite_wallpapers/presentations/views/categaries.dart';

import 'package:infinite_wallpapers/presentations/views/image.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  MyController controller = MyController();
  var categorieslist = StaticImagesCategories().catagories;
  @override
  void initState() {
    super.initState();
    WallheavenApiCall();
  }

  bool searchTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MySliverAppBar(context, controller),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
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
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: WallheavenApiCall(),
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
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                var wallpaper = snapshot.data!.data![index];
                                return InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Setwallpaper(
                                          imgUrl: snapshot
                                              .data!.data![index].path
                                              .toString(),
                                          controller: controller,
                                        ),
                                      )),
                                  child: Container(
                                      height: 200,
                                      width: 200,
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      decoration: const BoxDecoration(),
                                      child: Image.network(
                                        wallpaper.thumbs!.large.toString(),
                                        fit: BoxFit.cover,
                                      )),
                                );
                              });
                        } else {
                          return Container(
                            child: const Text(' loading data '),
                          );
                        }
                      }),
                ),
                MaterialButton(
                  onPressed: () {
                    int pageno = 2;

                    WallheavenApiCall(page: pageno.toString());
                    pageno++;
                  },
                  child: Text('loade more'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
