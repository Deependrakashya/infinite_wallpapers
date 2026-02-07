import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_walls/viewmodels/wallpaper_view_model.dart';

class Setwallpaper extends StatefulWidget {
  final String imgUrl;
  const Setwallpaper({
    super.key,
    required this.imgUrl,
  });

  @override
  State<Setwallpaper> createState() => _SetwallpaperState();
}

class _SetwallpaperState extends State<Setwallpaper> {
  final WallpaperViewModel viewModel = Get.put(WallpaperViewModel());

  @override
  void dispose() {
    viewModel.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imgUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Dark Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50,
            left: 20,
            child: ClipOval(
              child: Material(
                color: Colors.black26,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom Interaction Area
          Positioned(
            left: 20,
            right: 20,
            bottom: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (viewModel.isDownloadDone.value) return const SizedBox();
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: viewModel.isDownloading.value
                          ? null
                          : () => viewModel.downloadImage(widget.imgUrl),
                      child: viewModel.isDownloading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'SET WALLPAPER',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  );
                }),
                Obx(() {
                  if (!viewModel.isDownloadDone.value) return const SizedBox();
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Image Ready',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Click below to set as wallpaper using the system tools. This allows you to crop and choose the location safely.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () =>
                              viewModel.applyWallpaper(widget.imgUrl),
                          icon: const Icon(Icons.wallpaper_rounded),
                          label: const Text('PROCEED TO SET'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          // Fullscreen Loading Overlay
          // Obx(() {
          //   if (viewModel.isSettingWallpaper.value) {
          //     return Positioned.fill(
          //       child: Container(
          //         color: Colors.black.withOpacity(0.7),
          //         child: Center(
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               CircularProgressIndicator(
          //                 color: theme.colorScheme.primary,
          //               ),
          //               const SizedBox(height: 20),
          //               const Text(
          //                 "Opening Wallpaper Chooser...",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w600,
          //                   decoration: TextDecoration.none,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   }
          //   return const SizedBox.shrink();
          // }),
        ],
      ),
    );
  }
}
