package com.devquorix.zenwalls

import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.File
import java.io.FileInputStream
import java.io.IOException

class MainActivity: FlutterActivity() {
    private val TAG = "ZenWallsNative"
    private val CHANNEL = "com.vaky.aio/wallpaper"

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "MainActivity onCreate called. Activity hash: ${System.identityHashCode(this)}")
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "MainActivity onResume called")
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "MainActivity onPause called")
    }

    override fun onDestroy() {
        Log.d(TAG, "MainActivity onDestroy called")
        super.onDestroy()
    }

    override fun onConfigurationChanged(newConfig: android.content.res.Configuration) {
        super.onConfigurationChanged(newConfig)
        Log.d(TAG, "onConfigurationChanged: $newConfig")
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setWallpaper") {
                val path = call.argument<String>("path")
                val location = call.argument<Int>("location")

                Log.d(TAG, "setWallpaper called on Activity hash: ${System.identityHashCode(this@MainActivity)}")
                Log.d(TAG, "Parameters -> path: $path, location: $location")

                if (path == null || location == null) {
                    Log.e(TAG, "Invalid arguments: path or location is null")
                    result.error("INVALID_ARGUMENTS", "Path or location is null", null)
                    return@setMethodCallHandler
                }

                // Launch Coroutine on IO Dispatcher to avoid blocking the Main Thread
                CoroutineScope(Dispatchers.IO).launch {
                    try {
                        val file = File(path)
                        if (!file.exists()) {
                            Log.e(TAG, "File not found at: $path")
                            withContext(Dispatchers.Main) {
                                result.error("FILE_NOT_FOUND", "File does not exist at $path", null)
                            }
                            return@launch
                        }

                        val wallpaperManager = WallpaperManager.getInstance(applicationContext)

                        // 1. Determine if we need to downsample to prevent OOM/Freeze on system side
                        // We check the Image headers first
                        val options = BitmapFactory.Options().apply { inJustDecodeBounds = true }
                        BitmapFactory.decodeFile(path, options)
                        
                        val imgWidth = options.outWidth
                        val imgHeight = options.outHeight
                        Log.d(TAG, "Original Image Dimensions: ${imgWidth}x${imgHeight}")

                        // Get Screen Dimensions
                        val metrics = resources.displayMetrics
                        val screenWidth = metrics.widthPixels
                        val screenHeight = metrics.heightPixels
                        Log.d(TAG, "Screen Dimensions: ${screenWidth}x${screenHeight}")

                        // If image is significantly larger than screen (e.g. > 2.5x total pixels or > 3000px on any side)
                        // we downsample to avoid system-side freezing.
                        val shouldDownsample = imgWidth > screenWidth * 2 || imgHeight > screenHeight * 2 || imgWidth > 3000 || imgHeight > 3000

                        if (shouldDownsample) {
                            Log.d(TAG, "Image is oversized. Downsampling...")
                            val sampleSize = calculateInSampleSize(imgWidth, imgHeight, screenWidth * 2, screenHeight * 2)
                            Log.d(TAG, "Calculated inSampleSize: $sampleSize")
                            
                            val downsampleOptions = BitmapFactory.Options().apply {
                                inSampleSize = sampleSize
                                inPreferredConfig = Bitmap.Config.RGB_565 // 16-bit to save memory
                            }
                            
                            val bitmap = BitmapFactory.decodeFile(path, downsampleOptions)
                            if (bitmap != null) {
                                Log.d(TAG, "Downsampled Bitmap size: ${bitmap.width}x${bitmap.height}")
                                try {
                                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                                        val flags = when (location) {
                                            1 -> WallpaperManager.FLAG_SYSTEM
                                            2 -> WallpaperManager.FLAG_LOCK
                                            3 -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
                                            else -> WallpaperManager.FLAG_SYSTEM
                                        }
                                        wallpaperManager.setBitmap(bitmap, null, false, flags)
                                    } else {
                                        wallpaperManager.setBitmap(bitmap)
                                    }
                                    Log.d(TAG, "Wallpaper set using downsampled Bitmap")
                                } finally {
                                    bitmap.recycle()
                                }
                            } else {
                                throw IOException("Failed to decode downsampled bitmap")
                            }
                        } else {
                            // FAST PATH: "Zero-Copy" stream-based approach for reasonably sized images
                            Log.d(TAG, "Image size is acceptable. using setStream (Zero-Copy)...")
                            FileInputStream(file).use { stream ->
                                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                                    val flags = when (location) {
                                        1 -> WallpaperManager.FLAG_SYSTEM
                                        2 -> WallpaperManager.FLAG_LOCK
                                        3 -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
                                        else -> WallpaperManager.FLAG_SYSTEM
                                    }
                                    // Use allowBackup = false to minimize system overhead
                                    wallpaperManager.setStream(stream, null, false, flags)
                                } else {
                                    wallpaperManager.setStream(stream)
                                }
                                Unit
                            }
                            Log.d(TAG, "Wallpaper set using setStream")
                        }

                        withContext(Dispatchers.Main) {
                            Log.d(TAG, "Returning success to Flutter")
                            result.success(true)
                        }
                    } catch (e: Throwable) {
                        Log.e(TAG, "Fatal error setting wallpaper", e)
                        withContext(Dispatchers.Main) {
                            result.error("SET_WALLPAPER_FAILED", "Failed to set wallpaper: ${e.message}", null)
                        }
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun calculateInSampleSize(width: Int, height: Int, reqWidth: Int, reqHeight: Int): Int {
        var inSampleSize = 1
        if (height > reqHeight || width > reqWidth) {
            val halfHeight: Int = height / 2
            val halfWidth: Int = width / 2
            while (halfHeight / inSampleSize >= reqHeight && halfWidth / inSampleSize >= reqWidth) {
                inSampleSize *= 2
            }
        }
        return inSampleSize
    }
}
