import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aniverse_2/domain/entities/streaming_service.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/data/models/anime_model.dart';

class JikanApi {
  final String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<dynamic>> fetchTopAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('API response data: $data'); // Debug print
      return data['data'] ?? []; // Handle potential null value
    } else {
      print('Failed to load top anime: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load top anime');
    }
  }

  Future<List<StreamingService>> fetchStreamingServices(int animeId) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$animeId/streaming'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<StreamingService> services = (data['data'] as List)
          .map((service) => StreamingService.fromJson(service))
          .toList();
      print('Streaming services: $services'); // Debug print
      return services;
    } else {
      print('Failed to load streaming services: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load streaming services');
    }
  }

  Future<Map<String, List<String>>> fetchThemes(int animeId) async {
    final response = await http.get(Uri.parse('$baseUrl/anime/$animeId/themes'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, List<String>> themes = {
        'openings': (data['data']['openings'] as List<dynamic>).map((theme) => theme as String).toList(),
        'endings': (data['data']['endings'] as List<dynamic>).map((theme) => theme as String).toList(),
      };
      print('Themes: $themes'); // Debug print
      return themes;
    } else {
      print('Failed to load themes: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load themes');
    }
  }

  Future<List<Anime>> searchAnime(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Anime> results = (data['data'] as List)
          .map((anime) => AnimeModel.fromJson(anime))
          .toList();
      print('Search results: $results'); // Debug print
      return results;
    } else {
      print('Failed to search anime: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to search anime');
    }
  }

  Future<List<Anime>> fetchCurrentSeasonAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/seasons/now'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<Anime> results = (data['data'] as List)
          .map((anime) => AnimeModel.fromJson(anime))
          .toList();
      return results;
    } else {
      throw Exception('Failed to load current season anime');
    }
  }
}
