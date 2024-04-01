import 'package:flutter/material.dart';
import '../establishments/establishmentscharts/schoolsstatictis.dart';
import '../establishments/establishmentsdata/schoolsdata.dart';
import '../constants.dart';



void main() {
  runApp(MaterialApp(
    home: SchoolsMenu(),
  ));
}

class SchoolsMenu extends StatefulWidget {
  @override
  _SchoolsMenuState createState() => _SchoolsMenuState();
}

class _SchoolsMenuState extends State<SchoolsMenu> {
  List<Map<String, dynamic>> filteredSchools = SchoolsData.schoolsData;
  bool showStatistics = false;

  void _filterData(String name, String location, int total) {
    setState(() {
      filteredSchools = SchoolsData.schoolsData.where((school) {
        final schoolName = school['School Name'].toString().toLowerCase();
        final schoolLocation = school['Place'].toString().toLowerCase();
        final schoolTotal = school['Total'] as int;

        final filterName = name.toLowerCase();
        final filterLocation = location.toLowerCase();

        return schoolName.contains(filterName) &&
            schoolLocation.contains(filterLocation) &&
            schoolTotal >= total;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150), 
          child: AppBar(
            title: Text('ملاعب المدارس'),
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
                decoration: InputDecoration(labelText: 'الاسم'),
              ),
              TextField(
                onChanged: (value) => _filterData('', value, 0),
                decoration: InputDecoration(labelText: 'الموقع'),
              ),
              TextField(
                onChanged: (value) => _filterData('', '', int.parse(value)),
                decoration: InputDecoration(labelText: 'عدد الملاعب'),
                keyboardType: TextInputType.number,
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
                              title: Text('بيانات المدسة', ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var entry in filteredSchools[index].entries)
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
                            '${filteredSchools[index]['School Name']}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Place: ${filteredSchools[index]['Place']}'),
                              Text('Total: ${filteredSchools[index]['Total']}'),
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
                      'Count: ${filteredSchools.length}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    if (showStatistics)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SchoolStatistics(
                                schoolsData: filteredSchools,
                              ),
                            ),
                          );
                        },
                        child: Text('إحصاء'),
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
