import 'package:aniverse_2/core/jikan_api.dart';
import 'package:aniverse_2/data/models/anime_model.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/repositories/anime_repository.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final JikanApi api;

  AnimeRepositoryImpl({required this.api});

  @override
  Future<List<Anime>> getTopAnime() async {
    final List<dynamic> animeList = await api.fetchTopAnime();
    print('Repository fetched data: $animeList'); // Debug print
    return animeList.map<Anime>((anime) => AnimeModel.fromJson(anime)).toList();
  }
}
