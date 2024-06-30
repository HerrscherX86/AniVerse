import 'package:flutter/material.dart';

class StreamingServiceCard extends StatelessWidget {
  final String name;
  final String url;
  final VoidCallback onTap;

  StreamingServiceCard({required this.name, required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        ),
        onPressed: onTap,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
