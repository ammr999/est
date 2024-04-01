import 'package:flutter/material.dart';
import '../clubsdata/alnasrfootballplayersdata.dart';
import '../clubscharts/alnasrfootballplayersdatadashboard.dart';
import '../../constants.dart';

class AlnasrPlayersList extends StatefulWidget {
  @override
  _AlnasrPlayersListState createState() => _AlnasrPlayersListState();
}

class _AlnasrPlayersListState extends State<AlnasrPlayersList> {
  final List<Map<String, dynamic>> players = AlnasrFootballPlayersData.alnasrFootballPlayersData;
  String filterNationality = '';
  String filterClass = '';
  String filterSeason = '';
  String filterTeam = '';
  String filterName = '';  // New filter for Name
  int selectedPlayerIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = players.where((player) {
      return player['Name'].toString().contains(filterName) &&  // Include the filter for Name
          player['Nationality'].toString().contains(filterNationality) &&
          player['Class'].toString().contains(filterClass) &&
          player['Season'].toString().contains(filterSeason) &&
          player['Team'].toString().contains(filterTeam);
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
                TextField(  // New TextField for Name filter
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
                            filterClass = value;
                          });
                        },
                        controller: TextEditingController(text: filterClass),
                        decoration: InputDecoration(
                          labelText: 'البحث عن طريق الفئة',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      onChanged: (value) {
                        setState(() {
                          filterClass = value!;
                        });
                      },
                      items: ['إماراتي', 'مقيم', 'حملة جواز', 'أبناء موطنات',''].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('اختر الفئة'),
                    ),
                  ],
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
                        controller: TextEditingController(text: filterSeason),
                        decoration: InputDecoration(
                          labelText: 'البحث عن طريق الموسم',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      onChanged: (value) {
                        setState(() {
                          filterSeason = value!;
                        });
                      },
                      items: ['2019-2020', '2020-2021', '2021-2022', '2022-2023', '2023-2024',''].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text('اختر الموسم'),
                    ),
                  ],
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
                      builder: (context) => AlnasrFootballStatistics(players: players),
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
