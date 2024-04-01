import '../../constants.dart';
import 'package:flutter/material.dart';
import 'clubslist.dart';
import 'fitnesslist.dart';
import 'sportserviceslist.dart';
import 'academieslist.dart';

class EstablishmentsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/Background.png'),
      )),
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
          ),
          itemCount: buttonData.length,
          padding: EdgeInsets.fromLTRB(50, 100, 50, 50),
          itemBuilder: (BuildContext context, int index) {
            return buildFloatingButton(
              context,
              buttonData[index]['label'],
              buttonData[index]['image'],
              index,
            );
          },
        ),
      ),
    );
  }

  Widget buildFloatingButton(
      BuildContext context, String label, String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        _navigateTo(context, index);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: shadowcolor,
              blurRadius: 5.0,
              spreadRadius: 5.0,
              offset: Offset(0, 0),
            ),
          ],
            gradient: LinearGradient(   // Gradient color added here
            colors: [Gradienttop, Gradientbuttom], // Use the colors you desire here
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: bordercolor,
                width: 0.0,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    color: const Color.fromARGB(255, 255, 255, 255),

                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: subtitleTextStyle,
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

  void _navigateTo(BuildContext context, int index) {
    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = AcademiesListMenu();
        break;
      case 1:
        targetPage = ClubListMenu();
        break;
      case 2:
        targetPage = SpportServicesListMenu();
        break;
      case 3:
        targetPage = FitnessListMenu();
        break;
      default:
        throw Exception('Unknown index: $index');
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) => targetPage,
      ),
    );
  }
}

final List<Map<String, dynamic>> buttonData = [
  {
    'label': 'الأكاديميات الخاصة',
    'image': 'assets/images/icons/sport-centre.png',
  },
  {
    'label': 'الأندية الرياضية',
    'image': 'assets/images/icons/soccer-player.png',
  },
  {
    'label': 'الخدمات الرياضية',
    'image': 'assets/images/icons/balls-sports.png',
  },
  {
    'label': 'مراكز لياقة بدنية',
    'image': 'assets/images/icons/gym.png',
  },
];
