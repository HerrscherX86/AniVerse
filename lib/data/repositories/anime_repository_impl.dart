import 'package:aniverse_2/core/jikan_api.dart';
import 'package:aniverse_2/data/models/anime_model.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final JikanApi api;

  // Constructor for AnimeRepositoryImpl, initializing with a JikanApi instance
  AnimeRepositoryImpl({required this.api});

  // Override the getTopAnime method to fetch the top anime from the Jikan API
  @override
  Future<List<Anime>> getTopAnime() async {
    // Fetch the list of top anime from the API
    final List<dynamic> animeList = await api.fetchTopAnime();
    print('Repository fetched data: $animeList'); // Debug print

    // Map the fetched data to a list of Anime objects using AnimeModel
    return animeList.map<Anime>((anime) => AnimeModel.fromJson(anime)).toList();
  }
}
