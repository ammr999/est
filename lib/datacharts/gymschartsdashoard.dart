import 'package:flutter/material.dart';
import '../data/gymsdata.dart'; // Import your gyms data from the file



class GenderAndRankPieChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Gender and Rank Pie Charts'),
        flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage('images/header.jpg'),
                fit: BoxFit.cover,
                ),
              ),
            ), // This sets the AppBar color to #a38966

      ),
      body: GenderPieChart(),
    );
  }
}

class GenderPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int mixedCount = 0;
    int femaleCount = 0;
    int rank1Count = 0;
    int rank2Count = 0;
    int rank3Count = 0;
    int rank4Count = 0;
    int rank5Count = 0;
    int totalTrainers = 0;
    int totalMembers = 0;

    // Count the number of entries for Gender and Rank
    for (var gym in GymsData.gymData) {
      if (gym['Gender'] == 'Mixed') {
        mixedCount++;
      } else if (gym['Gender'] == 'Female') {
        femaleCount++;
      }

      switch (gym['Rank']) {
        case 1:
          rank1Count++;
          break;
        case 2:
          rank2Count++;
          break;
        case 3:
          rank3Count++;
          break;
        case 4:
          rank4Count++;
          break;
        case 5:
          rank5Count++;
          break;
        default:
          break;
      }

      final trainerValue = gym['Trainer'];
      if (trainerValue is String) {
        totalTrainers += int.tryParse(trainerValue) ?? 0;
      } else if (trainerValue is int) {
        totalTrainers += trainerValue;
      }
      final membersValue = gym['Members'];
      if (membersValue is String) {
        totalMembers += int.tryParse(membersValue) ?? 0;
      } else if (membersValue is int) {
        totalMembers += membersValue;
      }
    }

    final totalGender = mixedCount + femaleCount;
    final mixedPercentage = (mixedCount / totalGender * 100).toStringAsFixed(1);
    final femalePercentage =
        (femaleCount / totalGender * 100).toStringAsFixed(1);

    final totalRank = rank1Count + rank2Count + rank3Count + rank4Count + rank5Count;
    final rank1Percentage = (rank1Count / totalRank * 100).toStringAsFixed(1);
    final rank2Percentage = (rank2Count / totalRank * 100).toStringAsFixed(1);
    final rank3Percentage = (rank3Count / totalRank * 100).toStringAsFixed(1);
    final rank4Percentage = (rank4Count / totalRank * 100).toStringAsFixed(1);
    final rank5Percentage = (rank5Count / totalRank * 100).toStringAsFixed(1);

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: 40,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Gender Distribution',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: GenderPieChartPainter(mixedCount, femaleCount),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.pink,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Female - $femalePercentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Mixed - $mixedPercentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Rank Distribution',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: CustomPaint(
                    painter: RankPieChartPainter(
                      rank1Count,
                      rank2Count,
                      rank3Count,
                      rank4Count,
                      rank5Count,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rank 1 - $rank1Percentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rank 2 - $rank2Percentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rank 3 - $rank3Percentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rank 4 - $rank4Percentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Rank 5 - $rank5Percentage%',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Total Members and Trainers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Members: $totalMembers',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 20),
              Text(
                'Total Trainers: $totalTrainers',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}

class GenderPieChartPainter extends CustomPainter {
  final int mixedCount;
  final int femaleCount;

  GenderPieChartPainter(this.mixedCount, this.femaleCount);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    final total = mixedCount + femaleCount;
    double startRadian = 0.0;

    final mixedArcAngle = (mixedCount / total) * 2 * 3.1415926535897932;
    final femaleArcAngle = (femaleCount / total) * 2 * 3.1415926535897932;

    final mixedPaint = Paint()..color = Colors.blue;
    final femalePaint = Paint()..color = Colors.pink;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      mixedArcAngle,
      true,
      mixedPaint,
    );
    startRadian += mixedArcAngle;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      femaleArcAngle,
      true,
      femalePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RankPieChartPainter extends CustomPainter {
  final int rank1Count;
  final int rank2Count;
  final int rank3Count;
  final int rank4Count;
  final int rank5Count;

  RankPieChartPainter(
    this.rank1Count,
    this.rank2Count,
    this.rank3Count,
    this.rank4Count,
    this.rank5Count,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    final total =
        rank1Count + rank2Count + rank3Count + rank4Count + rank5Count;
    double startRadian = 0.0;

    final rank1ArcAngle =
        (rank1Count / total) * 2 * 3.1415926535897932;
    final rank2ArcAngle =
        (rank2Count / total) * 2 * 3.1415926535897932;
    final rank3ArcAngle =
        (rank3Count / total) * 2 * 3.1415926535897932;
    final rank4ArcAngle =
        (rank4Count / total) * 2 * 3.1415926535897932;
    final rank5ArcAngle =
        (rank5Count / total) * 2 * 3.1415926535897932;

    final rank1Paint = Paint()..color = Colors.red;
    final rank2Paint = Paint()..color = Colors.orange;
    final rank3Paint = Paint()..color = Colors.yellow;
    final rank4Paint = Paint()..color = Colors.green;
    final rank5Paint = Paint()..color = Colors.blue;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      rank1ArcAngle,
      true,
      rank1Paint,
    );
    startRadian += rank1ArcAngle;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      rank2ArcAngle,
      true,
      rank2Paint,
    );
    startRadian += rank2ArcAngle;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      rank3ArcAngle,
      true,
      rank3Paint,
    );
    startRadian += rank3ArcAngle;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      rank4ArcAngle,
      true,
      rank4Paint,
    );
    startRadian += rank4ArcAngle;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startRadian,
      rank5ArcAngle,
      true,
      rank5Paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
