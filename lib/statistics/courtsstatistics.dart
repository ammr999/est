import 'package:flutter/material.dart';
import '../constants.dart';


class CourtsStatistics extends StatelessWidget {
  final List<Map<String, dynamic>> courtsData;

  CourtsStatistics({required this.courtsData});

  @override
  Widget build(BuildContext context) {
    // Implement the statistics widget here based on the courtsData
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150), 
          child: AppBar(
            title: Text('ملاعب رياضية'),
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
        child: Text(
          'Statistics Page',
          style: titlecustomTextStyle,
        ),
      ),
    );
  }
}