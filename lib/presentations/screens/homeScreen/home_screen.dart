import 'package:flutter/material.dart';
import 'package:infinite_wallpapers/model/ApiCall/clustured_api.dart';
import 'package:infinite_wallpapers/presentations/views/image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClusturedPhotosApiCall();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('infinite_wallpapers'),
              expandedHeight: 100.0,
            ),
            SliverToBoxAdapter(
                child: FutureBuilder(
                    future: ClusturedPhotosApiCall(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Text(' loading data '),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                              itemCount: snapshot.data!.photos!.length,
                              itemBuilder: (context, index) {
                                return image(snapshot, index);
                              }),
                        );
                      } else {
                        return Container(
                          child: Text(' loading data '),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
