import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('infinite_wallpapers'),
              expandedHeight: 100.0,
            ),
            SliverToBoxAdapter(
                child: FutureBuilder(
                    future: ClusturedPhotosApiCall(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: const Text(' loading data '),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.photos!.length,
                            itemBuilder: (context, index) {
                              return Column(children: [
                                ListTile(
                                  title: Text(snapshot.data!.photos![index].photographer.toString()),
                                ),
                                image(snapshot, index)
                              ]);
                              
                            });
                      } else {
                        return Container(
                          child: const Text(' loading data '),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
