import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:webview_flutter/webview_flutter.dart';

// Screen to display anime news from Anime News Network
class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // List to hold news items
  List<NewsItem> _newsItems = [];
  // Boolean to show loading indicator
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();  // Fetch news items on initialization
  }

  // Method to fetch news from the RSS feed
  Future<void> _fetchNews() async {
    final response = await http.get(Uri.parse('https://www.animenewsnetwork.com/news/rss.xml?ann-edition=us'));
    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');
      final newsItems = items.map((item) {
        final title = item.findElements('title').single.text;
        final link = item.findElements('link').single.text;
        final description = item.findElements('description').single.text;
        final pubDate = item.findElements('pubDate').single.text;
        return NewsItem(title, link, description, pubDate);
      }).toList();

      // Update state with fetched news items and hide loading indicator
      setState(() {
        _newsItems = newsItems;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Set the background color to white
      appBar: AppBar(
        title: Text('The Anime News Network'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())  // Show loading indicator if news is still loading
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          final newsItem = _newsItems[index];
          return Card(
            color: Colors.white,  // Set the card color to white
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: ListTile(
              title: Text(newsItem.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(newsItem.pubDate),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(url: newsItem.link),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Class to represent a news item
class NewsItem {
  final String title;
  final String link;
  final String description;
  final String pubDate;

  // Constructor to initialize a news item
  NewsItem(this.title, this.link, this.description, this.pubDate);
}

// Screen to display news details in a WebView
class NewsDetailScreen extends StatelessWidget {
  final String url;

  // Constructor to initialize with the news URL
  NewsDetailScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
