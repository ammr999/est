import 'package:flutter/material.dart';
import 'talentdata.dart';
import '../../constants.dart';
import '../../datacharts/tallentchartsdashboard.dart';

class TalentPlayersList extends StatefulWidget {
  @override
  _TalentPlayersListState createState() => _TalentPlayersListState();
}

class _TalentPlayersListState extends State<TalentPlayersList> {
  final List<Map<String, dynamic>> players = TalentData.talentData;
  String filterText = '';
  int selectedPlayerIndex = -1;

  List<Map<String, dynamic>> filterPlayers() {
    return players.where((player) {
      return player['Arabic Name'].toString().toLowerCase().contains(filterText.toLowerCase()) ||
          player['Position'].toString().toLowerCase().contains(filterText.toLowerCase()) ||
          player['Nationality'].toString().toLowerCase().contains(filterText.toLowerCase()) ||
          player['Age'].toString().contains(filterText) ||
          player['Team']?.toString().toLowerCase().contains(filterText.toLowerCase()) == true ||
          player['Sport']?.toString().toLowerCase().contains(filterText.toLowerCase()) == true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = filterPlayers();

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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filterText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'البحث عن طريق مكان اللعب، الجنسية، الفريق، الرياضة أو العمر',
              ),
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
                          title: Text('Name: ${filteredData[index]['Arabic Name']}'),
                          subtitle: Text('Position: ${filteredData[index]['Position']} - Nationality: ${filteredData[index]['Nationality']} - Team: ${filteredData[index]['Team']} - Sport: ${filteredData[index]['Sport']}'),
                        ),
                        if (selectedPlayerIndex == index) Divider(),
                        if (selectedPlayerIndex == index)
                          for (var entry in filteredData[index].entries)
                            if (entry.key != 'Arabic Name' &&
                                entry.key != 'Position' &&
                                entry.key != 'Nationality')
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                  Navigator.push( context,
                  MaterialPageRoute(builder: (context) => TalentStatistics(players: players)),
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
