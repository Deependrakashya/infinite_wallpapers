import 'dart:convert';

import 'package:infinite_wallpapers/model/wellhaven/wellhaven.dart';
import 'package:http/http.dart' as https;

Future<Wallhaven> WallheavenApiCall(
    {String? search, String? purity, String? sorting, String? page}) async {
  // Default values if parameters are null
  search ??= 'anime';
  page ??= '1';
  sorting ??= 'relevance';
  purity ??= '100'; // '100' for SFW, you can adjust based on your needs.

  final baseUrl = 'https://wallhaven.cc/api/v1/search';
  final finalUrl =
      '$baseUrl?q=$search&purity=$purity&page=$page&sorting=$sorting&per_page=100';
  print(finalUrl.toString());

  // final finalUrl = 'https://wallhaven.cc/api/v1/search?q=anime';
  final response = await https.get(Uri.parse(finalUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(' wallheaven api successfully called');
    print(data.toString());
    return Wallhaven.fromJson(data);
  } else {
    print('Failed to load photos: ${response.statusCode}');
    throw 'data not found ';
  }
}
