import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zen_walls/data/models/clustered_images/clustered_images.dart';

class PexelsRepository {
  static const String _baseUrl = 'api.pexels.com';
  static const String _authKey =
      'X4XsklGpZ2PNKqqaMR01n53ee5Pyv9ZpatIvcs9DhQ5PrYfhM8z8c6jm';

  Future<ClusteredPhotos> fetchCuratedPhotos(String page) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/curated',
      {'page': page, 'per_page': '80'},
    );

    final response = await http.get(url, headers: {
      'Authorization': _authKey,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ClusteredPhotos.fromJson(data);
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }

  Future<ClusteredPhotos> searchPhotos(String search, String page) async {
    final url = Uri.https(
      _baseUrl,
      '/v1/search',
      {'query': search, 'page': page, 'per_page': '80'},
    );

    final response = await http.get(url, headers: {
      'Authorization': _authKey,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ClusteredPhotos.fromJson(data);
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }
}
