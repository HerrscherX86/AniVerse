import 'package:aniverse_2/core/jikan_api.dart';
import 'package:aniverse_2/domain/entities/streaming_service.dart';
import 'package:flutter/material.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/usecases/get_top_anime.dart';

class AnimeProvider with ChangeNotifier {
  final GetTopAnime getTopAnime;

  AnimeProvider({required this.getTopAnime});

  List<Anime> _animeList = [];
  List<Anime> get animeList => _animeList;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<StreamingService> _streamingServices = [];
  List<StreamingService> get streamingServices => _streamingServices;

  List<String> _openingThemes = [];
  List<String> get openingThemes => _openingThemes;

  List<String> _endingThemes = [];
  List<String> get endingThemes => _endingThemes;

  List<Anime> _searchResults = [];
  List<Anime> get searchResults => _searchResults;

  List<Anime> _seasonAnime = [];
  List<Anime> get seasonAnime => _seasonAnime;

  Future<void> fetchTopAnime() async {
    try {
      _animeList = await getTopAnime();
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching anime: $e';
      notifyListeners();
    }
  }

  Future<void> fetchStreamingServices(int animeId) async {
    try {
      _streamingServices = await JikanApi().fetchStreamingServices(animeId);
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching streaming services: $e';
      notifyListeners();
    }
  }

  Future<void> fetchThemes(int animeId) async {
    try {
      Map<String, List<String>> themes = await JikanApi().fetchThemes(animeId);
      _openingThemes = themes['openings'] ?? [];
      _endingThemes = themes['endings'] ?? [];
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching themes: $e';
      notifyListeners();
    }
  }

  Future<void> searchAnime(String query) async {
    try {
      _searchResults = await JikanApi().searchAnime(query);
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error searching anime: $e';
      notifyListeners();
    }
  }

  Future<void> fetchCurrentSeasonAnime() async {
    try {
      _seasonAnime = await JikanApi().fetchCurrentSeasonAnime();
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching current season anime: $e';
      notifyListeners();
    }
  }
}
