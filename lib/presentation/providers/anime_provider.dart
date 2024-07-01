import 'package:aniverse_2/core/jikan_api.dart';
import 'package:aniverse_2/domain/entities/streaming_service.dart';
import 'package:flutter/material.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:aniverse_2/domain/usecases/get_top_anime.dart';

// AnimeProvider class that extends ChangeNotifier for state management
class AnimeProvider with ChangeNotifier {
  // Use case for getting the top anime
  final GetTopAnime getTopAnime;

  // Constructor to initialize the provider with the GetTopAnime use case
  AnimeProvider({required this.getTopAnime});

  // Private list to hold the anime data
  List<Anime> _animeList = [];
  // Public getter for the anime list
  List<Anime> get animeList => _animeList;

  // Private variable to hold error messages
  String _errorMessage = '';
  // Public getter for the error message
  String get errorMessage => _errorMessage;

  // Private list to hold streaming services
  List<StreamingService> _streamingServices = [];
  // Public getter for the streaming services list
  List<StreamingService> get streamingServices => _streamingServices;

  // Private list to hold opening themes
  List<String> _openingThemes = [];
  // Public getter for the opening themes list
  List<String> get openingThemes => _openingThemes;

  // Private list to hold ending themes
  List<String> _endingThemes = [];
  // Public getter for the ending themes list
  List<String> get endingThemes => _endingThemes;

  // Private list to hold search results
  List<Anime> _searchResults = [];
  // Public getter for the search results list
  List<Anime> get searchResults => _searchResults;

  // Private list to hold the current season anime
  List<Anime> _seasonAnime = [];
  // Public getter for the season anime list
  List<Anime> get seasonAnime => _seasonAnime;

  // Method to fetch the top anime and notify listeners
  Future<void> fetchTopAnime() async {
    try {
      // Fetch the top anime using the GetTopAnime use case
      _animeList = await getTopAnime();
      // Clear any previous error message
      _errorMessage = '';
      // Notify listeners of the state change
      notifyListeners();
    } catch (e) {
      // Set the error message and notify listeners
      _errorMessage = 'Error fetching anime: $e';
      notifyListeners();
    }
  }

  // Method to fetch streaming services for a specific anime and notify listeners
  Future<void> fetchStreamingServices(int animeId) async {
    try {
      // Fetch the streaming services using the Jikan API
      _streamingServices = await JikanApi().fetchStreamingServices(animeId);
      // Clear any previous error message
      _errorMessage = '';
      // Notify listeners of the state change
      notifyListeners();
    } catch (e) {
      // Set the error message and notify listeners
      _errorMessage = 'Error fetching streaming services: $e';
      notifyListeners();
    }
  }

  // Method to fetch opening and ending themes for a specific anime and notify listeners
  Future<void> fetchThemes(int animeId) async {
    try {
      // Fetch the themes using the Jikan API
      Map<String, List<String>> themes = await JikanApi().fetchThemes(animeId);
      // Set the opening and ending themes
      _openingThemes = themes['openings'] ?? [];
      _endingThemes = themes['endings'] ?? [];
      // Clear any previous error message
      _errorMessage = '';
      // Notify listeners of the state change
      notifyListeners();
    } catch (e) {
      // Set the error message and notify listeners
      _errorMessage = 'Error fetching themes: $e';
      notifyListeners();
    }
  }

  // Method to search for anime based on a query and notify listeners
  Future<void> searchAnime(String query) async {
    try {
      // Search for anime using the Jikan API
      _searchResults = await JikanApi().searchAnime(query);
      // Clear any previous error message
      _errorMessage = '';
      // Notify listeners of the state change
      notifyListeners();
    } catch (e) {
      // Set the error message and notify listeners
      _errorMessage = 'Error searching anime: $e';
      notifyListeners();
    }
  }

  // Method to fetch the current season anime and notify listeners
  Future<void> fetchCurrentSeasonAnime() async {
    try {
      // Fetch the current season anime using the Jikan API
      _seasonAnime = await JikanApi().fetchCurrentSeasonAnime();
      // Clear any previous error message
      _errorMessage = '';
      // Notify listeners of the state change
      notifyListeners();
    } catch (e) {
      // Set the error message and notify listeners
      _errorMessage = 'Error fetching current season anime: $e';
      notifyListeners();
    }
  }
}
