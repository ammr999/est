import 'package:flutter/material.dart';
import 'communitiescourtsdata.dart';
import '/constants.dart';

void main() {
  runApp(MaterialApp(
    home: CommunitiesCourtsMenu(),
  ));
}

class CommunitiesCourtsMenu extends StatefulWidget {
  @override
  _SchoolsMenuState createState() => _SchoolsMenuState();
}

class _SchoolsMenuState extends State<CommunitiesCourtsMenu> {
  List<Map<String, dynamic>> filteredSchools = CommunitiesCourtsData.communitiesCourtsData;
  bool showStatistics = false;

  List<String> keysToSum = [
    'Parks', 'Jogging', 'Tennis', 'Squash', 'Basket Ball', 'Paddle', 'Football',
    'Kids Area', 'Swimming', 'Table Tennis', 'Billiard & Pool', 'Badminton',
    'Gym', 'Games Room', 'VolleyBall', 'Skate Park', 'Athlatecs', 'BaseBall',
    'Weight Lifting Park', 'American Football', 'Sport Hall', 'Shooting Alskton',
    'Sport Complex', 'Golf', 'Cricket', 'Car Race', 'Shooting',''
  ];

  int getTotalCount() {
    int sum = 0;
    for (var school in filteredSchools) {
      for (var key in keysToSum) {
        if (school.containsKey(key) && school[key].isNotEmpty) {
          sum += int.tryParse(school[key]) ?? 0;  // Convert string value to integer; if conversion fails, add 0.
        }
      }
    }
    return sum;
  }

  void _filterData(String name, String location) {
    setState(() {
      filteredSchools = CommunitiesCourtsData.communitiesCourtsData.where((school) {
        final schoolName = school['Community Name'].toString().toLowerCase();
        final schoolLocation = school['Sub Community'].toString().toLowerCase();

        final filterName = name.toLowerCase();
        final filterLocation = location.toLowerCase();

        return schoolName.contains(filterName) &&
            schoolLocation.contains(filterLocation);
      }).toList();
    });
  }

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
      body: Container(
        color: Color(0xFFFFF0), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => _filterData(value, ''),
                decoration: InputDecoration(labelText: 'الاسم'),
              ),
              TextField(
                onChanged: (value) => _filterData('', value),
                decoration: InputDecoration(labelText: 'الموقع'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSchools.length,
                  itemBuilder: (context, index) {
                    Color cardColor;
                    if (index % 5 == 0) {
                      cardColor = blue2;
                    } else if (index % 5 == 1) {
                      cardColor = blue3;
                    } else if (index % 5 == 2) {
                      cardColor = blue4;
                    } else if (index % 5 == 3) {
                      cardColor = blue5;
                    } else {
                      cardColor = blue6;
                    }

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('بيانات مناطق الترويح الرياضي بدبي'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var entry in filteredSchools[index].entries)
                                      if (entry.value != '0' && entry.value.toString().isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Text('${entry.key}:'),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  entry.value.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        color: cardColor,
                        child: ListTile(
                          title: Text('${filteredSchools[index]['Community Name']}'),
                          subtitle: Text('Place: ${filteredSchools[index]['Sub Community']}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Color(0xFF3498db),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'المجموع: ${filteredSchools.length}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Total count: ${getTotalCount()}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    if (showStatistics)
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('تحليل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF27ae60),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
