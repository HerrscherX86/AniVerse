import 'package:aniverse_2/domain/entities/anime.dart';

abstract class AnimeRepository {
  Future<List<Anime>> getTopAnime();
}
