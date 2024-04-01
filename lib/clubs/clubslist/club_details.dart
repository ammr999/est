import 'package:flutter/material.dart';


class ClubDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String clubName;

  ClubDetailsScreen({required this.imageUrl, required this.clubName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150), 
          child: AppBar(
            //title: Text('App Title'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage('images/header.jpg'),
                fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl, height: 200, width: 200),
            SizedBox(height: 20),
            Text(clubName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            // Add more club details as needed
          ],
        ),
      ),
    );
  }
}
