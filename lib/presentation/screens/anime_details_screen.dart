import 'package:flutter/material.dart';
import 'package:aniverse_2/domain/entities/anime.dart';
import 'package:provider/provider.dart';
import 'package:aniverse_2/presentation/providers/anime_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/details_section.dart';
import '../widgets/streaming_service_card.dart';
import 'webview_screen.dart';

// Screen to display detailed information about an anime
class AnimeDetailsScreen extends StatefulWidget {
  final Anime anime;

  // Constructor to initialize with the selected anime
  AnimeDetailsScreen({required this.anime});

  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch streaming services and themes after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AnimeProvider>(context, listen: false).fetchStreamingServices(widget.anime.malId);
      Provider.of<AnimeProvider>(context, listen: false).fetchThemes(widget.anime.malId);
    });
  }

  // Helper method to get embedded video URL for YouTube
  String getEmbeddedVideoUrl(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.host.contains('youtube.com')) {
      return 'https://www.youtube.com/embed/${uri.queryParameters['v']}';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              widget.anime.imageUrl, // Use large_image_url
              fit: BoxFit.cover,
            ),
          ),
          // DraggableScrollableSheet for details
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Anime title, image, and rating
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(widget.anime.imageUrl, height: 150, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.anime.title,
                                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange, size: 30),
                                    SizedBox(width: 5),
                                    Text(
                                      widget.anime.score.toString(),
                                      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'MAL ID: ${widget.anime.malId}',
                                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Anime details: length, type, episodes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoColumn('Length', '${widget.anime.episodes ?? 0} ep'),
                          _buildInfoColumn('Type', widget.anime.type),
                          _buildInfoColumn('Episodes', widget.anime.episodes.toString()),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Detailed sections: storyline, genres, studios, producers
                      DetailsSection(title: 'Storyline', content: widget.anime.synopsis),
                      DetailsSection(title: 'Genres', content: widget.anime.genres.join(', ')),
                      DetailsSection(title: 'Studios', content: widget.anime.studios.join(', ')),
                      DetailsSection(title: 'Producers', content: widget.anime.producers.join(', ')),
                      Consumer<AnimeProvider>(
                        builder: (context, provider, child) {
                          final streamingServices = provider.streamingServices;
                          final openingThemes = provider.openingThemes;
                          final endingThemes = provider.endingThemes;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display opening themes if available
                              if (openingThemes.isNotEmpty)
                                DetailsSection(title: 'Opening Themes', content: openingThemes.join('\n')),
                              // Display ending themes if available
                              if (endingThemes.isNotEmpty)
                                DetailsSection(title: 'Ending Themes', content: endingThemes.join('\n')),
                              SizedBox(height: 20),
                              // Streaming services section
                              Text(
                                'Available on:',
                                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              // List of streaming service cards
                              ...streamingServices.map((service) => StreamingServiceCard(
                                name: service.name,
                                url: service.url,
                                onTap: () async {
                                  final url = service.url;
                                  if (url.isNotEmpty && await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              )),
                              SizedBox(height: 20),
                              // Trailer section
                              if (widget.anime.trailerUrl.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Watch Trailer:',
                                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    SizedBox(height: 10),
                                    // Display trailer in a WebView
                                    LayoutBuilder(
                                      builder: (BuildContext context, BoxConstraints constraints) {
                                        final width = constraints.maxWidth;
                                        final height = width * 9 / 16;
                                        return Container(
                                          width: width,
                                          height: height,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: WebViewScreen(url: getEmbeddedVideoUrl(widget.anime.trailerUrl)),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Transparent AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build information columns
  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
