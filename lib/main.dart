import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniverse_2/core/jikan_api.dart';
import 'package:aniverse_2/data/repositories/anime_repository_impl.dart';
import 'package:aniverse_2/domain/usecases/get_top_anime.dart';
import 'package:aniverse_2/presentation/providers/anime_provider.dart';
import 'package:aniverse_2/presentation/providers/auth_provider.dart';
import 'package:aniverse_2/presentation/screens/season_anime_screen.dart';
import 'package:aniverse_2/presentation/screens/about_screen.dart';
import 'package:aniverse_2/presentation/screens/news_screen.dart';
import 'package:aniverse_2/presentation/screens/search_screen.dart';
import 'package:aniverse_2/presentation/screens/auth_screen.dart';  // Use the combined auth screen
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  final JikanApi api = JikanApi();
  final AnimeRepositoryImpl repository = AnimeRepositoryImpl(api: api);
  final GetTopAnime getTopAnime = GetTopAnime(repository: repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimeProvider(getTopAnime: getTopAnime)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),  // Add AuthProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky7 AniVerse',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.orange,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.orange),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.black),
          displayMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
      ),
      home: AuthScreen(),  // Start with the combined auth screen
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    SeasonAnimeScreen(), // Set Season Anime Screen as the home screen
    SearchScreen(), // Add SearchScreen
    NewsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.white,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Season"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Colors.orange),
          SalomonBottomBarItem(
            icon: Icon(Icons.article),
            title: Text("News"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
              icon: Icon(Icons.info),
              title: Text("About App"),
              selectedColor: Colors.orange),
        ],
      ),
    );
  }
}
