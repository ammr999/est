import 'package:flutter/material.dart';
import '../clubsdata/hattafootballplayersdata.dart';
import '../../constants.dart';
import '../clubscharts/hattafootballplayersdatadashboard.dart';

class HattaPlayersList extends StatefulWidget {
  @override
  _HattaPlayersListState createState() => _HattaPlayersListState();
}

class _HattaPlayersListState extends State<HattaPlayersList> {
  final List<Map<String, dynamic>> players = 
      HattaFootballPlayersData.hattaFootballPlayersData;
  String filterName = '';
  String filterTeam = '';
  String filterNationality = '';
  String filterSeason = '';
  String filterClass = '';
  int selectedPlayerIndex = -1;

  List<String> seasons = ['2019-2020', '2020-2021', '2021-2022', '2022-2023', '2023-2024',''];
  List<String> classes = ['إماراتي', 'مقيم', 'حملة جواز', 'أبناء موطنات',''];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = players.where((player) {
      return player['Name'].toString().contains(filterName) &&
          player['Team'].toString().contains(filterTeam) &&
          player['Nationality'].toString().contains(filterNationality) &&
          player['Season'].toString().contains(filterSeason) &&
          (filterClass.isEmpty || player['Class'].toString().contains(filterClass));
    }).toList();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      filterName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'البحث عن طريق الاسم',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      filterTeam = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'البحث عن طريق الفريق',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      filterNationality = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'البحث عن طريق الجنسية',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filterSeason = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'البحث عن طريق الموسم',
                        ),
                        controller: TextEditingController(text: filterSeason),
                      ),
                    ),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          filterSeason = newValue!;
                        });
                      },
                      items: seasons.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filterClass = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'البحث عن طريق الفئة',
                        ),
                        controller: TextEditingController(text: filterClass),
                      ),
                    ),
                    SizedBox(width: 8),
                    DropdownButton<String>(
                      onChanged: (String? newValue) {
                        setState(() {
                          filterClass = newValue!;
                        });
                      },
                      items: classes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
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
                    setState(() {
                      if (selectedPlayerIndex == index) {
                        selectedPlayerIndex = -1;
                      } else {
                        selectedPlayerIndex = index;
                      }
                    });
                  },
                  child: Card(
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('Name: ${filteredData[index]['Name']}'),
                          subtitle: Text('Team: ${filteredData[index]['Team']}'),
                          trailing: Text('Season: ${filteredData[index]['Season']}'),
                        ),
                        if (selectedPlayerIndex == index) Divider(),
                        if (selectedPlayerIndex == index)
                          for (var entry in filteredData[index].entries)
                            if (entry.key != 'Name' && entry.key != 'Team' && entry.key != 'Season')
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(entry.key),
                                    Text(entry.value.toString()),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المجموع: ${filteredData.length}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HattaFootballStatistics(players: players),
                    ),
                  );
                },
                child: Text('تحليل'),
                backgroundColor: Color(0xFFf39c12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
