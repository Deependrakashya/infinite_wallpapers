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

import android.content.Intent
import android.net.Uri
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo

class MainActivity: FlutterActivity() {
    private val TAG = "ZenWallsNative"
    private val CHANNEL = "com.devquorix.zenwalls/wallpaper"

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
            if (call.method == "showWallpaperChooser") {
                val uriString = call.argument<String>("uri")
                if (uriString == null) {
                    result.error("INVALID_ARGUMENT", "URI string is null", null)
                    return@setMethodCallHandler
                }
                
                showWallpaperChooser(uriString)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun showWallpaperChooser(uriString: String) {
        try {
            val uri = Uri.parse(uriString)
            val baseIntent = Intent(Intent.ACTION_ATTACH_DATA)
            baseIntent.setDataAndType(uri, "image/*")
            baseIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            baseIntent.putExtra("mimeType", "image/*")
            baseIntent.clipData = android.content.ClipData.newRawUri("Wallpaper", uri)

            val packageManager = packageManager
            
            // 1. Try to target Google Photos directly
            val googlePhotosPackage = "com.google.android.apps.photos"
            val googlePhotosIntent = Intent(baseIntent)
            googlePhotosIntent.setPackage(googlePhotosPackage)
            
            val googlePhotosResolveInfo = packageManager.resolveActivity(googlePhotosIntent, 0)
            
            if (googlePhotosResolveInfo != null) {
                 Log.d(TAG, "Google Photos found. Launching directly.")
                 // Explicitly grant permission to the target package
                 grantUriPermission(googlePhotosPackage, uri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
                 startActivity(googlePhotosIntent)
                 return
            }

            // 2. Fallback to filtered chooser if Google Photos is not available
            val resolveInfos = packageManager.queryIntentActivities(baseIntent, 0)
            val targetedIntents = ArrayList<Intent>()

            for (info in resolveInfos) {
                val packageName = info.activityInfo.packageName
                val lowerPackageName = packageName.toLowerCase()
                
                // Allow known wallpaper/gallery apps
                val isAllowed = lowerPackageName.contains("wallpaper") ||
                                lowerPackageName.contains("gallery") ||
                                lowerPackageName.contains("photos") ||
                                lowerPackageName.contains("picker") ||
                                lowerPackageName.contains("launcher") ||
                                lowerPackageName.contains("systemui") ||
                                lowerPackageName.contains("android")

                // Explicitly exclude messaging/social apps if they happen to declare the intent
                val isExcluded = lowerPackageName.contains("whatsapp") ||
                                 lowerPackageName.contains("telegram") ||
                                 lowerPackageName.contains("messenger") ||
                                 lowerPackageName.contains("facebook") ||
                                 lowerPackageName.contains("instagram")

                if (isAllowed && !isExcluded) {
                    val intent = Intent(baseIntent)
                    intent.setPackage(packageName)
                    intent.setClassName(packageName, info.activityInfo.name)
                    targetedIntents.add(intent)
                }
            }

            if (targetedIntents.isNotEmpty()) {
                val chooserIntent = Intent.createChooser(targetedIntents.removeAt(0), "Set Wallpaper")
                if (targetedIntents.isNotEmpty()) {
                    chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, targetedIntents.toTypedArray())
                }
                startActivity(chooserIntent)
            } else {
                // Fallback to standard chooser if no filters match
                startActivity(Intent.createChooser(baseIntent, "Set Wallpaper"))
            }

        } catch (e: Exception) {
            Log.e(TAG, "Error showing wallpaper chooser", e)
        }
    }
}
