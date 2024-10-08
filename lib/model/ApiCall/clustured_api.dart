import 'dart:convert';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:http/http.dart' as https;

// List<ClusturedPhotos> clusturedImages ;

Future<ClusturedPhotos> ClusturedPhotosApiCall() async {
  print('ClusturedPhotosApiCalled');
  final url = Uri.https(
    'api.pexels.com', // Base URL
    '/v1/curated', // Path
    {'page': '2', 'per_page': '80'}, // Query parameters
  );

  final response = await https.get(url, headers: {
    'Authorization': 'X4XsklGpZ2PNKqqaMR01n53ee5Pyv9ZpatIvcs9DhQ5PrYfhM8z8c6jm'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    return ClusturedPhotos.fromJson(data);//
  } else {
    print('Failed to load photos: ${response.statusCode}');
    throw 'data not found ';
  }
}
