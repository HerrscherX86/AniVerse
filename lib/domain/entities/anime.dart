class Anime {
  // The unique identifier for the anime from MyAnimeList
  final int malId;

  // The title of the anime
  final String title;

  // URL to the anime's image
  final String imageUrl;

  // A brief synopsis of the anime
  final String synopsis;

  // The number of episodes in the anime
  final int episodes;

  // The score/rating of the anime
  final double score;

  // The type of anime (e.g., TV, Movie)
  final String type;

  // The current status of the anime (e.g., Airing, Finished)
  final String status;

  // The airing period of the anime
  final String aired;

  // List of genres associated with the anime
  final List<String> genres;

  // List of studios that produced the anime
  final List<String> studios;

  // List of producers involved in the anime
  final List<String> producers;

  // URL to the anime's trailer
  final String trailerUrl;

  // List of opening themes for the anime
  final List<String> openingThemes;

  // List of ending themes for the anime
  final List<String> endingThemes;

  // URL to the streaming service for the anime
  final String streamingUrl;

  // Constructor to initialize all fields of the Anime class
  Anime({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.episodes,
    required this.score,
    required this.type,
    required this.status,
    required this.aired,
    required this.genres,
    required this.studios,
    required this.producers,
    required this.trailerUrl,
    required this.openingThemes,
    required this.endingThemes,
    required this.streamingUrl,
  });
}
