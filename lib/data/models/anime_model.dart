import 'package:aniverse_2/domain/entities/anime.dart';

class AnimeModel extends Anime {
  AnimeModel({
    required int malId,
    required String title,
    required String imageUrl,
    required String synopsis,
    required int episodes,
    required double score,
    required String type,
    required String status,
    required String aired,
    required List<String> genres,
    required List<String> studios,
    required List<String> producers,
    required String trailerUrl,
    required List<String> openingThemes,
    required List<String> endingThemes,
    required String streamingUrl,
  }) : super(
    malId: malId,
    title: title,
    imageUrl: imageUrl,
    synopsis: synopsis,
    episodes: episodes,
    score: score,
    type: type,
    status: status,
    aired: aired,
    genres: genres,
    studios: studios,
    producers: producers,
    trailerUrl: trailerUrl,
    openingThemes: openingThemes,
    endingThemes: endingThemes,
    streamingUrl: streamingUrl,
  );

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    // Debugging statements to print the JSON response
    print('Parsing AnimeModel from JSON: $json');

    final trailerUrl = json['trailer']?['url'] ?? '';
    final streamingUrl = json['streaming']?['url'] ?? '';

    print('Parsed trailer URL: $trailerUrl'); // Debugging
    print('Parsed streaming URL: $streamingUrl'); // Debugging

    return AnimeModel(
      malId: json['mal_id'],
      title: json['title'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? json['images']['jpg']['image_url'] ?? '',
      synopsis: json['synopsis'] ?? '',
      episodes: json['episodes'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      aired: json['aired']['string'] ?? '',
      genres: (json['genres'] as List<dynamic>?)
          ?.map((genre) => genre['name'] as String)
          .toList() ??
          [],
      studios: (json['studios'] as List<dynamic>?)
          ?.map((studio) => studio['name'] as String)
          .toList() ??
          [],
      producers: (json['producers'] as List<dynamic>?)
          ?.map((producer) => producer['name'] as String)
          .toList() ??
          [],
      trailerUrl: trailerUrl,
      openingThemes: (json['opening_themes'] as List<dynamic>?)
          ?.map((theme) => theme as String)
          .toList() ??
          [],
      endingThemes: (json['ending_themes'] as List<dynamic>?)
          ?.map((theme) => theme as String)
          .toList() ??
          [],
      streamingUrl: streamingUrl,
    );
  }
}
