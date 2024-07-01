import 'package:aniverse_2/domain/entities/anime.dart';

// Abstract class that defines the contract for an Anime Repository
abstract class AnimeRepository {
  // Method to fetch the list of top anime
  // This method should be implemented by any concrete class that implements this interface
  Future<List<Anime>> getTopAnime();
}
