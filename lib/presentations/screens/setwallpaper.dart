import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zen_walls/getx.dart';
import 'package:zen_walls/presentations/views/setwallpaper_views.dart';
import 'package:zen_walls/services/setwallpaper_handler.dart';
import 'package:get/get.dart';

class Setwallpaper extends StatefulWidget {
  final String imgUrl;
  final MyController controller;
  const Setwallpaper({
    super.key,
    required this.imgUrl,
    required this.controller,
  });

  @override
  State<Setwallpaper> createState() => _SetwallpaperState();
}

class _SetwallpaperState extends State<Setwallpaper> {
  bool setwallpaperbutton = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              widget.imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Dark Overlay for better visibility of UI
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
            bottom: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (widget.controller.downloadingDone.value)
                    return const SizedBox();
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
                      onPressed: () => downloadAndSetWallpaper(
                        widget.imgUrl,
                        widget.controller,
                      ),
                      child: const Text(
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
                  if (!widget.controller.downloadingDone.value)
                    return const SizedBox();
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: setwallpaperbutton
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 8),
                              _buildOptionButton(
                                context,
                                label: 'Home Screen',
                                icon: Icons.home_outlined,
                                onTap: () {
                                  setHomeScreen(widget.imgUrl);
                                  setState(() => setwallpaperbutton = false);
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildOptionButton(
                                context,
                                label: 'Lock Screen',
                                icon: Icons.lock_outline,
                                onTap: () {
                                  setLockScreen(widget.imgUrl);
                                  setState(() => setwallpaperbutton = false);
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildOptionButton(
                                context,
                                label: 'Both Screens',
                                icon: Icons.phonelink_setup_outlined,
                                onTap: () {
                                  setBothScreen(widget.imgUrl);
                                  setState(() => setwallpaperbutton = false);
                                },
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const Text(
                                'Applying Wallpaper...',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),
                            ],
                          ),
                  );
                }),
              ],
            ),
          ),

          Positioned(
            child: Obx(() {
              if (!widget.controller.downloading.value) return const SizedBox();
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        'SAVING IMAGE...',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.controller.downloadedData.value,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.downloading.value = false;
    widget.controller.downloadingDone.value = false;
    widget.controller.setWallpaperLoader.value = false;
    super.dispose();
  }
}
