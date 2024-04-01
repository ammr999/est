
import 'package:flutter/material.dart';
import 'alnasracademydata.dart';
import '../../constants.dart';


void main() {
  runApp(MaterialApp(
    home: AlnasrAcademyPlayersList(),
  ));
}

class AlnasrAcademyPlayersList extends StatefulWidget {
  @override
  _AlnasrAcademyPlayersListState createState() =>
      _AlnasrAcademyPlayersListState();
}

class _AlnasrAcademyPlayersListState extends State<AlnasrAcademyPlayersList> {
  final List<Map<String, dynamic>> players = AlnasrAcademyData.alnasrAcademyData;
  String filterText = '';
  int selectedPlayerIndex = -1;

  void _showPlayerDetails(BuildContext context, Map<String, dynamic> player) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('بيانات اللاعب'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var entry in player.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = players.where((player) {
      return player['Arabic Name'].toString().contains(filterText) ||
          player['Position'].toString().contains(filterText) ||
          player['Nationality'].toString().contains(filterText) ||
          player['Age'].toString().contains(filterText);
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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filterText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'البحث عن طريق الاسم أو خانة اللعب أو الجنسية أو العمر',
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
                          subtitle: Text('Position: ${filteredData[index]['Position']}'),
                          trailing: Text('Nationality: ${filteredData[index]['Nationality']}'),
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
                },
                child: Text('إحصاءات'),
                backgroundColor: Color(0xFFf39c12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
