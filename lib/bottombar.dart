import 'package:flutter/material.dart';
import '../academies/academieslist/alahliacademyplayerslist.dart';
import '../academies/academieslist/alnasracademyplayerslist.dart';
import '../academies/academieslist/alwaslacademyplayerslist.dart';
import '../academies/academieslist/hataacademyplayerslist.dart';
import '../academies/academieslist/privateacademiesplayerslist.dart';
import 'constants.dart';

class DashboardBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Row(
            children: [
              Text('أحمد سالم'),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
              _buildPopupMenu(),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuButton<int> _buildPopupMenu() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('theme 1'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('theme 2'),
        ),
        // Add more PopupMenuItems as needed
      ],
      onSelected: (value) {
        // Handle menu selection
      },
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text('بيانات عامة'),
          decoration: BoxDecoration(
            color: boardColors[0],
          ),
        ),
        ListTile(
          title: Text('أكاديمية نادي شباب الأهلي'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlahliAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('أكاديمية نادي النصر'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlnasrAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('أكاديمية نادي الوصل'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlwaslAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('أكاديمية نادي حتا'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HattaAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('الأكاديميات الخاصة'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PrivateAcademiesPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('شركات مراكز اللياقة البدنية'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlahliAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('شركات الأندية الرياضية الخاصة'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlahliAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('الملاعب الرياضية بدبي'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlahliAcademyPlayersList(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('الملاعب الرياضية بالمدارس الخاصة'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlahliAcademyPlayersList(),
              ),
            );
          },
        ),
      ],
    ),
  );
}
