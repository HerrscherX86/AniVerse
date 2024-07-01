import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/repositories/anime_repository.dart';

// Use case class for getting the top anime
class GetTopAnime {
  // The repository instance used to fetch the top anime
  final AnimeRepository repository;

  // Constructor to initialize the GetTopAnime use case with a repository
  GetTopAnime({required this.repository});

  // Call method to execute the use case and get the top anime
  Future<List<Anime>> call() async {
    // Fetch the top anime from the repository and return the result
    return await repository.getTopAnime();
  }
}
