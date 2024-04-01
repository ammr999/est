import 'package:flutter/material.dart';
import '../datacharts/gymschartsdashoard.dart';
import '../data/gymsdata.dart';
import '../constants.dart';

void main() {
  runApp(MaterialApp(
    home: FitnessCentersMenu(),
  ));
}

class FitnessCentersMenu extends StatefulWidget {
  @override
  _FitnessCentersMenuState createState() => _FitnessCentersMenuState();
}

class _FitnessCentersMenuState extends State<FitnessCentersMenu> {
  final List<Map<String, dynamic>> gyms = GymsData.gymData;
  String filterText = '';
  int selectedGymIndex = -1;

  void _showGymDetails(BuildContext context, Map<String, dynamic> gym) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Gym Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var entry in gym.entries)
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
    List<Map<String, dynamic>> filteredData = gyms.where((gym) {
      return gym['Name'].toString().contains(filterText) ||
          gym['Location'].toString().contains(filterText) ||
          gym['Rank'].toString().contains(filterText);
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150), 
          child: AppBar(
            title: Text('مراكز اللياقة البدنية'),
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
                labelText: 'البحث بالاسم أو الموقع أو التصنيف',
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
                      if (selectedGymIndex == index) {
                        selectedGymIndex = -1;
                      } else {
                        selectedGymIndex = index;
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
                          subtitle: Text('Location: ${filteredData[index]['Location']}'),
                          trailing: Text('Rank: ${filteredData[index]['Rank']}'),
                        ),
                        if (selectedGymIndex == index) Divider(),
                        if (selectedGymIndex == index)
                          for (var entry in filteredData[index].entries)
                            if (entry.key != 'Name' && entry.key != 'Location' && entry.key != 'Rank')
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
                    MaterialPageRoute(builder: (context) => GenderPieChart()),
                  );
                },
                child: Text('إحصاء'),
                backgroundColor: Color(0xFFf39c12), // Orange color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
