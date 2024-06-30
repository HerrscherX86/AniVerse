class Anime {
  final int malId;
  final String title;
  final String imageUrl;
  final String synopsis;
  final int episodes;
  final double score;
  final String type;
  final String status;
  final String aired;
  final List<String> genres;
  final List<String> studios;
  final List<String> producers;
  final String trailerUrl;
  final List<String> openingThemes;
  final List<String> endingThemes;
  final String streamingUrl;

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
