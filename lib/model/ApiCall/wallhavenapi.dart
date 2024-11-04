import 'dart:convert';

import 'package:infinite_wallpapers/model/wellhaven/wellhaven.dart';
import 'package:http/http.dart' as https;

Future<Wallhaven> WallheavenApiCall(
    {String? search,
    String? purity,
    String? sorting,
    String? page,
    String? path}) async {
  // Default values if parameters are null
  search ??= 'anime';
  page ??= '1';
  sorting ??= 'relevance';
  purity ??= '111';
  path ??=
      'anime&categories=010&purity=000&ratios=9x16&sorting=relevance&order=desc&ai_art_filter=0&page=1';

  // '100' for SFW, you can adjust based on your needs.
  String apikey = "lzq0ReYyoMEjtIarTSc4rCnYbDTJPeUy&q";

  final baseUrl = 'https://wallhaven.cc/api/v1/search';

  final finalUrl =
      '$baseUrl?q=$path&categories=010&ratios=9x16&sorting=relevance&order=desc&page=$page';

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
