import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/repositories/anime_repository.dart';

class GetTopAnime {
  final AnimeRepository repository;

  GetTopAnime({required this.repository});

  Future<List<Anime>> call() async {
    return await repository.getTopAnime();
  }
}
