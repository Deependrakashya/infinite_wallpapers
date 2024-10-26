import 'dart:convert';

import 'package:infinite_wallpapers/model/wellhaven/wellhaven.dart';
import 'package:http/http.dart' as https;

Future<Wallhaven> WallheavenApiCall(
    {String? search, String? purity, String? sorting, String? page}) async {
  // Default values if parameters are null
  search ??= 'anime';
  page ??= '1';
  sorting ??= 'relevance';
  purity ??= '111';
  // '100' for SFW, you can adjust based on your needs.
  String apikey = "lzq0ReYyoMEjtIarTSc4rCnYbDTJPeUy&q";

  final baseUrl = 'https://wallhaven.cc/api/v1/search';
  // final finalUrl = '$baseUrl?q=categories=010&sorting=$sorting&apikey=$apikey';
  final finalUrl = '$baseUrl?categories=010&purity=110';
  // final finalUrl =
  //     'https://wallhaven.cc/api/v1/search?q=categories=101&page=$page&purity=111&page=1&sorting=relevance&per_page=24&apikey=$apikey&ratios=16x9';
  print(finalUrl.toString());

  // final finalUrl = 'https://wallhaven.cc/api/v1/search?q=anime';
  final response = await https.get(Uri.parse(finalUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(' wallheaven api successfully called');
    // print(data.toString());
    return Wallhaven.fromJson(data);
  } else {
    print('Failed to load photos: ${response.statusCode}');
    throw 'data not found ';
  }
}
