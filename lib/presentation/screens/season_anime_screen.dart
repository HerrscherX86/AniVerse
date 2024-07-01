import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniverse_2/presentation/providers/anime_provider.dart';
import 'anime_details_screen.dart';

// Screen to display anime airing this season
class SeasonAnimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set the background color to white
      appBar: AppBar(
        title: Text(
          'Anime Airing This Season',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Consumer<AnimeProvider>(
        builder: (context, provider, child) {
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));  // Display error message if any
          }
          if (provider.seasonAnime.isEmpty) {
            provider.fetchCurrentSeasonAnime();  // Fetch anime if the list is empty
            return Center(child: CircularProgressIndicator());  // Show loading indicator
          }
          // GridView to display the list of anime airing this season
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: provider.seasonAnime.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,  // Adjust aspect ratio for a taller image
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final anime = provider.seasonAnime[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailsScreen(anime: anime),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display anime image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          anime.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Display anime title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        anime.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
