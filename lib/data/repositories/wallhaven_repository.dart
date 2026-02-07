import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zen_walls/data/models/wallhaven/wallhaven.dart';

class WallhavenRepository {
  static const String _baseUrl = 'https://wallhaven.cc/api/v1/search';

  Future<Wallhaven> fetchPhotos({
    String? search,
    String? purity,
    String? sorting,
    String? page,
  }) async {
    // Default values
    final query = search ?? '';
    final currentPage = page ?? '1';
    final currentSorting = sorting ?? 'relevance';
    final currentPurity = purity ?? '111';

    final finalUrl =
        '$_baseUrl?q=$query&categories=010&ratios=9x16&sorting=$currentSorting&purity=$currentPurity&order=desc&page=$currentPage';

    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Wallhaven.fromJson(data);
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }
}
