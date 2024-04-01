import 'constants.dart';
import 'package:flutter/material.dart';
import 'menus/academiesmenu.dart';
import 'establishments/establishmentslist/fitnesscentersmenu.dart';
import 'menus/dubaiclubsmenu.dart';
import 'menus/schoolsmenu.dart';
import 'establishments/establishmentslist/sportcourtsmenu.dart';
import 'website.dart';
import 'data/talent/talentplayerslist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مجلس دبي الرياضي'),
      ),
      backgroundColor: mainbackgroundcolor, // Set the background color here
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of buttons per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: buttonData.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          return buildFloatingButton(
            context,
            buttonData[index]['label'],
            buttonData[index]['imagePath'],
            index, // Pass the index for navigation
          );
        },
      ),
    );
  }

  Widget buildFloatingButton(BuildContext context, String label, String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => AcademiesMenu(),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => SportCourtsMenu(),
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => DubaiClubsMenu(),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => TalentPlayersList(),
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => FitnessCentersMenu(),
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => SchoolsMenu(),
              ),
            );
            break;
          case 6:
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                pageBuilder: (context, animation, secondaryAnimation) => LaunchUrlApp(),
              ),
            );
            break;
        }
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: shadowcolor, // Updated shadow color
              blurRadius: 10,
              spreadRadius: 10.0,
              offset: Offset(2, 4),
            ),
          ],
          color: Color(0xFF7FA366), // Set the background color to black
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.7),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: titlecustomTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> buttonData = [
  {
    'label': 'أكاديميات رياضية',
    'imagePath': 'assets/images/Academies.png',
  },
  {
    'label': 'ملاعب رياضية',
    'imagePath': 'assets/images/Courts.png',
  },
  {
    'label': 'أندية دبي',
    'imagePath': 'assets/images/Dubaiclubs.png',
  },
  {
    'label': 'مواهب رياضية',
    'imagePath': 'assets/images/Talent.png',
  },
  {
    'label': 'مراكز لياقة بدنية',
    'imagePath': 'assets/images/Fitness.png',
  },
  {
    'label': 'المدارس',
    'imagePath': 'assets/images/Schools.png',
  },
  {
    'label': 'الخريطة',
    'imagePath': 'assets/images/Schools.png',
  },
];
