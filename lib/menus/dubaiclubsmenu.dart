import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../clubs/clubslist/alwasldetails.dart';
import '../clubs/clubslist/alnasrdetails.dart';
import '../clubs/clubslist/alahlidetails.dart';
import '../clubs/clubslist/chessclubdetails.dart';
import '../clubs/clubslist/hattadetails.dart';
import '../clubs/clubslist/peopleoddetails.dart';


class DubaiClubsMenu extends StatelessWidget {
  final List<MenuItemModel> menuItems = [
    MenuItemModel(imageUrl: 'assets/images/alahli.png', title: 'شباب الاهلي'),
    MenuItemModel(imageUrl: 'assets/images/alnasr.png', title: 'نادي النصر'),
    MenuItemModel(imageUrl: 'assets/images/alwasl.png', title: 'نادي الوصل'),
    MenuItemModel(imageUrl: 'assets/images/hatta.png', title: 'نادي حتا'),
    MenuItemModel(imageUrl: 'assets/images/peopleod.png', title: 'نادي أصحاب الهمم'),
    MenuItemModel(imageUrl: 'assets/images/chess.png', title: 'نادي الشطرنج'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150), 
          child: AppBar(
            title: Text('الأندية الرياضية'),
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
      body: Container(
        color: Color(0xFFecf0f1), // Light Gray color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  viewportFraction: 0.3,
                  height: MediaQuery.of(context).size.height * 0.6,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                ),
                items: menuItems.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final MenuItemModel menuItem = entry.value;
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          _openDetailsPage(context, index);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MenuItemWidget(
                                imageUrl: menuItem.imageUrl,
                                title: menuItem.title,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetailsPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AlahliPlayersList()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AlnasrPlayersList()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AlwaslPlayersList()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HattaPlayersList()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleodDetails()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChessClubDetails()));
        break;
      default:
        break;
    }
  }
}

class MenuItemModel {
  final String imageUrl;
  final String title;

  MenuItemModel({required this.imageUrl, required this.title});
}

class MenuItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;

  MenuItemWidget({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageUrl, height: 100, width: 100),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
