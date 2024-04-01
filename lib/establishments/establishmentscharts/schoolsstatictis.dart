import 'package:flutter/material.dart';

class SchoolStatistics extends StatelessWidget {
  final List<Map<String, dynamic>> schoolsData;

  SchoolStatistics({required this.schoolsData});

  @override
  Widget build(BuildContext context) {
    // Implement your statistics widget here using the schoolsData
    // For example:
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
        child: Text('Your Statistics Widget'),
      ),
    );
  }
}
