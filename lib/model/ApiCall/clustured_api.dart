import 'dart:convert';
import 'package:infinite_wallpapers/model/clusturedImages/clusturedImages.dart';
import 'package:http/http.dart' as https;

// List<ClusturedPhotos> clusturedImages ;

Future<ClusturedPhotos> ClusturedPhotosApiCall(String page) async {
  final url = Uri.https(
    'api.pexels.com', // Base URL
    '/v1/curated', // Path
    {'page': page, 'per_page': '10'}, // Query parameters
  );
  print(url);

  final response = await https.get(url, headers: {
    'Authorization': 'X4XsklGpZ2PNKqqaMR01n53ee5Pyv9ZpatIvcs9DhQ5PrYfhM8z8c6jm'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // print(data.toString());
    print(ClusturedPhotos.fromJson(data));

    return ClusturedPhotos.fromJson(data); //
  } else {
    print('Failed to load photos: ${response.statusCode}');
    throw 'data not found ';
  }
}

Future<ClusturedPhotos> serachPexelapi(String search) async {
  final url = Uri.https(
    'api.pexels.com', // Base URL
    '/v1/search', // Path
    {'query': search, 'page': '1', 'per_page': '80'}, // Query parameters
  );
  var res = await https.get(url, headers: {
    'Authorization': 'X4XsklGpZ2PNKqqaMR01n53ee5Pyv9ZpatIvcs9DhQ5PrYfhM8z8c6jm'
  });
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body);
    // print(data.toString());
    print(ClusturedPhotos.fromJson(data));

    return ClusturedPhotos.fromJson(data); //
  } else {
    print('Failed to load photos: ${res.statusCode}');
    throw 'data not found ';
  }
}
