import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';  // Needed for BackdropFilter

// AboutScreen class to display information about the app and developer
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image covering the entire screen
          Image.asset(
            'assets/K1U.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Blur effect
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Semi-transparent white color
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // App title
                        Text(
                          'Sky7 AniVerse',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 16),
                        // App description
                        Text(
                          'AniVerse is an app that allows you to search and explore your favorite anime. Get details about anime, including genres, studios, and streaming services.',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        // Features title
                        Text(
                          'Features:',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        // List of features
                        Text(
                          '- Search for anime\n- View top anime\n- Detailed information about anime\n- Explore streaming services',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Divider(color: Colors.orange),
                        SizedBox(height: 16),
                        // Developer title
                        Text(
                          'Developer',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            // Developer's photo
                            ClipOval(
                              child: Image.asset(
                                'assets/icon/AppIcon3.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Developer's name
                                Text(
                                  'KiaFizz7',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                // Developer's description
                                Text(
                                  'IDK what to put here',
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ),
                                SizedBox(height: 8),
                                // Link to developer's GitHub profile
                                GestureDetector(
                                  onTap: () async {
                                    const url = 'https://github.com/HerrscherX86';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    }
                                  },
                                  child: Text(
                                    'Github/HerrscherX86',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.orange,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(color: Colors.orange),
                        SizedBox(height: 16),
                        // Special thanks title
                        Text(
                          'Special Thanks To:',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        // List of special thanks
                        Text(
                          '- Stack Overflow Forum\n- GPT-4o\n- Rekan-Rekan Seperjuangan Mata Kuliah Mobile',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
