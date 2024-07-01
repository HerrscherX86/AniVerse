import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniverse_2/presentation/providers/anime_provider.dart';
import 'anime_details_screen.dart';

// Screen for searching anime
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controller for search input field
  final TextEditingController _searchController = TextEditingController();

  // Method to trigger search
  void _search() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      Provider.of<AnimeProvider>(context, listen: false).searchAnime(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set the background color to white
      appBar: AppBar(
        title: Text(
          'Search It',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              // Search input field
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search anime...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.orange),
                    onPressed: _search,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                onSubmitted: (value) => _search(),
              ),
            ),
          ),
          Expanded(
            // Consumer to listen for changes in AnimeProvider
            child: Consumer<AnimeProvider>(
              builder: (context, provider, child) {
                if (provider.errorMessage.isNotEmpty) {
                  return Center(child: Text(provider.errorMessage));
                }
                if (provider.searchResults.isEmpty) {
                  return Center(child: Text('No results found.'));
                }
                // GridView to display search results
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: provider.searchResults.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,  // Adjust aspect ratio for a taller image
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final anime = provider.searchResults[index];
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
                          // Anime image
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
                          // Anime title
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
          ),
        ],
      ),
    );
  }
}
