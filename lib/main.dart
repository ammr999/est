import 'constants.dart';
import 'package:flutter/material.dart';
import 'switchcases.dart';
import 'topbar.dart';
import 'bottombar.dart';


//TWITTER 


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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/Background.png'),
        ),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 1 / 3),
          child: Dashboard(),
        ),
        backgroundColor: Colors.transparent,
        drawer: buildDrawer(context),
        body: _buildFloatingButtonsGrid(),
        bottomNavigationBar:
            DashboardBottomBar(), // This is imported from 'bottombar.dart'
      ),
    );
  }

  Widget _buildFloatingButtonsGrid() {
    return ListView.builder(
      itemCount: buttonCategories.length,
      itemBuilder: (BuildContext context, int categoryIndex) {
        final category = buttonCategories[categoryIndex];
        final buttons = category['buttons'] as List<Map<String, String>>;
        final categoryName = category['name'] as String;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: buttons.length,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return buildFloatingButton(
                  context,
                  buttons[index]['label']!,
                  buttons[index]['image']!,
                  index,
                  categoryName 
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildFloatingButton(
      BuildContext context, String label, String image, int index, String categoryName) {
    return GestureDetector(
      onTap: () {
        navigateBasedOnIndex(
            context, index, categoryName); // This is the function you are calling
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowcolor,
              blurRadius: 0.0,
              spreadRadius: 0.0,
              offset: Offset(0, 0),
            ),
          ],
          gradient: LinearGradient(
            // Gradient color added here
            colors: [
              Gradienttop,
              Gradientbuttom
            ], // Use the colors you desire here
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: bordercolor,
                  width: 0.0,
                ),
              ),
              child: Stack(
                children: [
                  // Position the Image 30 pixels from the bottom and centered horizontally
                  Positioned(
                    bottom: 20.0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      image,
                      width: 50,
                      height: 50,
                      //color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),

                  // Position the Text 50 pixels from the top and centered horizontally
                  Positioned(
                    top: 30.0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
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
              )),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> buttonCategories = [
    {
      'name': 'Talent Data',
      'buttons': [
        {
          'label': 'أكاديمية شباب الأهلي',
          'image': 'assets/images/icons/alahli_academy.png',
        },
        {
          'label': 'أكاديمية نادي النصر',
          'image': 'assets/images/icons/alnasr_academy.png',
        },
        {
          'label': 'أكاديمية نادي الوصل',
          'image': 'assets/images/icons/alwasl_academy.png',
        },
        {
          'label': 'أكاديمية حتا',
          'image': 'assets/images/icons/hatta_academy.png',
        },
        {
          'label': 'الأكاديميات الخاصة',
          'image': 'assets/images/icons/private_academies.png',
        },
        {
          'label': 'قائمة مواهب الأكاديميات الخاصة',
          'image': 'assets/images/icons/fans.png',
        },
      ],
    },
    {
      'name': 'Sport Facilities',
      'buttons': [
        {
        'label': 'ملاعب رياضية',
        'image': 'assets/images/icons/02.png',
        },
        {
          'label': 'المدارس',
          'image': 'assets/images/icons/sport-centre.png',
        },
        {
          'label': 'الترويح الرياضي',
          'image': 'assets/images/icons/courses.png',
        },
      ],
    },
    {
      'name': 'Dubai Clubs Players',
      'buttons': [
        {
          'label': 'شباب الاهلي',
          'image': 'assets/images/alahli.png',
        },
        {
          'label': 'نادي النصر',
          'image': 'assets/images/alnasr.png',
        },
        {
          'label': 'نادي الوصل',
          'image': 'assets/images/alwasl.png',
        },
        {
          'label': 'نادي حتا',
          'image': 'assets/images/hatta.png',
        },
        {
          'label': 'نادي أصحاب الهمم',
          'image': 'assets/images/POD.png',
        },
        {
          'label': 'نادي الشطرنج',
          'image': 'assets/images/chess.png',
        },
      ],
    },
    {
      'name': 'Sport Establishments',
      'buttons': [
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
        
      ],
    },
    {
      'name': 'Sport Leisure',
      'buttons': [
        {
          'label': 'الترويح الرياضي',
          'image': 'assets/images/icons/courses.png',
        },
        {
          'label': 'مراكز لياقة بدنية',
          'image': 'assets/images/icons/kettlebell.png',
        },
        {
          'label': 'المدارس',
          'image': 'assets/images/icons/sport-centre.png',
        },
        
      ],
    },
  ];
}





  

class _BoardWidgetState extends State<BoardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String? _previousText;


  @override
  void didUpdateWidget(BoardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.color,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Current text (fading out)
          Opacity(
            opacity: 1 - _fadeAnimation.value,
            child: Center(child: Text(_previousText!, style: widget.textStyle)),
          ),
          // New text (fading in)
          Opacity(
            opacity: _fadeAnimation.value,
            child: Center(child: Text(widget.text, style: widget.textStyle)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
