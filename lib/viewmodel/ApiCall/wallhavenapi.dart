import 'dart:convert';

import 'package:zen_walls/model/wellhaven/wellhaven.dart';
import 'package:http/http.dart' as https;

Future<Wallhaven> WallheavenApiCall(
    {String? search,
    String? purity,
    String? sorting,
    String? page,
    String? path}) async {
  // Default values if parameters are null
  search ??= '';
  page ??= '1';
  sorting ??= 'relevance';
  purity ??= '111';

  const baseUrl = 'https://wallhaven.cc/api/v1/search';

  final finalUrl =
      '$baseUrl?q=$search&categories=010&ratios=9x16&sorting=relevance&order=desc&page=$page';

  // print(finalUrl.toString());

  // final finalUrl = 'https://wallhaven.cc/api/v1/search?q=anime';
  final response = await https.get(Uri.parse(finalUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // print(' wallheaven api successfully called');
    // print(data.toString());
    return Wallhaven.fromJson(data);
  } else {
    // print('Failed to load photos: ${response.statusCode}');
    throw 'data not found ';
  }
}
