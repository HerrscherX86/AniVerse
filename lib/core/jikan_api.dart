import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aniverse_2/domain/entities/streaming_service.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/data/models/anime_model.dart';

class JikanApi {
  // Base URL for the Jikan API
  final String baseUrl = 'https://api.jikan.moe/v4';

  // Fetch the list of top anime
  Future<List<dynamic>> fetchTopAnime() async {
    // Send a GET request to the top anime endpoint
    final response = await http.get(Uri.parse('$baseUrl/top/anime'));

    // If the response is successful, decode the JSON data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print('API response data: $data'); // Debug print
      // Return the list of top anime, handle potential null value
      return data['data'] ?? [];
    } else {
      // Print the error message for debugging purposes
      print('Failed to load top anime: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Throw an exception if the request failed
      throw Exception('Failed to load top anime');
    }
  }

  // Fetch the list of streaming services for a specific anime
  Future<List<StreamingService>> fetchStreamingServices(int animeId) async {
    // Send a GET request to the streaming services endpoint
    final response = await http.get(Uri.parse('$baseUrl/anime/$animeId/streaming'));

    // If the response is successful, decode the JSON data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Map the JSON data to a list of StreamingService objects
      List<StreamingService> services = (data['data'] as List)
          .map((service) => StreamingService.fromJson(service))
          .toList();
      print('Streaming services: $services'); // Debug print
      return services;
    } else {
      // Print the error message for debugging purposes
      print('Failed to load streaming services: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Throw an exception if the request failed
      throw Exception('Failed to load streaming services');
    }
  }

  // Fetch the opening and ending themes for a specific anime
  Future<Map<String, List<String>>> fetchThemes(int animeId) async {
    // Send a GET request to the themes endpoint
    final response = await http.get(Uri.parse('$baseUrl/anime/$animeId/themes'));

    // If the response is successful, decode the JSON data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Map the JSON data to a map of opening and ending themes
      Map<String, List<String>> themes = {
        'openings': (data['data']['openings'] as List<dynamic>).map((theme) => theme as String).toList(),
        'endings': (data['data']['endings'] as List<dynamic>).map((theme) => theme as String).toList(),
      };
      print('Themes: $themes'); // Debug print
      return themes;
    } else {
      // Print the error message for debugging purposes
      print('Failed to load themes: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Throw an exception if the request failed
      throw Exception('Failed to load themes');
    }
  }

  // Search for anime based on a query string
  Future<List<Anime>> searchAnime(String query) async {
    // Send a GET request to the search anime endpoint
    final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));

    // If the response is successful, decode the JSON data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Map the JSON data to a list of Anime objects
      List<Anime> results = (data['data'] as List)
          .map((anime) => AnimeModel.fromJson(anime))
          .toList();
      print('Search results: $results'); // Debug print
      return results;
    } else {
      // Print the error message for debugging purposes
      print('Failed to search anime: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Throw an exception if the request failed
      throw Exception('Failed to search anime');
    }
  }

  // Fetch the list of anime currently showing this season
  Future<List<Anime>> fetchCurrentSeasonAnime() async {
    // Send a GET request to the current season anime endpoint
    final response = await http.get(Uri.parse('$baseUrl/seasons/now'));

    // If the response is successful, decode the JSON data
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // Map the JSON data to a list of Anime objects
      List<Anime> results = (data['data'] as List)
          .map((anime) => AnimeModel.fromJson(anime))
          .toList();
      return results;
    } else {
      // Throw an exception if the request failed
      throw Exception('Failed to load current season anime');
    }
  }
}
