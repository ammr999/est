import 'package:flutter/material.dart';
import '../establishments/establishmentscharts/schoolsstatictis.dart';
import '../data/dubaiclubsresultsdata.dart';
import '../constants.dart';




class DubaiClubsResultsMenuMenu extends StatefulWidget {
  @override
  _DubaiClubsResultsMenuMenuState createState() => _DubaiClubsResultsMenuMenuState();
}

class _DubaiClubsResultsMenuMenuState extends State<DubaiClubsResultsMenuMenu> {
  List<Map<String, dynamic>> filteredDubaiClubsResultsMenu = DubaiClubsResultsData.dubaiClubsResultsData;
  bool showStatistics = false;

  void _filterData(String name, String location, int total) {
    setState(() {
      filteredDubaiClubsResultsMenu = DubaiClubsResultsData.dubaiClubsResultsData.where((school) {
        final schoolName = school['الموسم'].toString().toLowerCase();
        final schoolLocation = school['اللعبة'].toString().toLowerCase();

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
            title: Text('نتائج أندية دبي'),
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
        color: Color(0xFFFFF0), // Ivory color (#FFFFF0)
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => _filterData(value, '', 0),
                decoration: InputDecoration(labelText: 'الموسم'),
              ),
              TextField(
                onChanged: (value) => _filterData('', value, 0),
                decoration: InputDecoration(labelText: 'اللعبة'),
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDubaiClubsResultsMenu.length,
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
                              title: Text(' نتائج أندية دبي', ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var entry in filteredDubaiClubsResultsMenu[index].entries)
                                      if (entry.value != 0 && entry.value.toString().isNotEmpty)
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
                          title: Text(
                            '${filteredDubaiClubsResultsMenu[index]['الموسم']}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Place: ${filteredDubaiClubsResultsMenu[index]['اللعبة']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Color(0xFF3498db), // Blue color
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Count: ${filteredDubaiClubsResultsMenu.length}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    if (showStatistics)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SchoolStatistics(
                                schoolsData: filteredDubaiClubsResultsMenu,
                              ),
                            ),
                          );
                        },
                        child: Text('تحليل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF27ae60), // Green color
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
