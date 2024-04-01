import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:charts_flutter/flutter.dart' as charts;
import '../establishmentsdata/courtsdata.dart';


class MyApp extends StatelessWidget {
  final List<Map<String, dynamic>> courtsData = SportCourtData.sportCourtData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChartsScreen(data: courtsData),
    );
  }
}

class ChartsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  ChartsScreen({required this.data});

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  List<Map<String, dynamic>> filteredData = [];

  TextEditingController activityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
  }

  void filterData() {
    setState(() {
      filteredData = widget.data.where((entry) {
        bool activityMatch = activityController.text.isEmpty || entry['Activity'].toString().toLowerCase().contains(activityController.text.toLowerCase());
        bool locationMatch = locationController.text.isEmpty || entry['Location'].toString().toLowerCase().contains(locationController.text.toLowerCase());
        bool genderMatch = genderController.text.isEmpty || entry['Gender'].toString().toLowerCase().contains(genderController.text.toLowerCase());
        bool typeMatch = typeController.text.isEmpty || entry['Type'].toString().toLowerCase().contains(typeController.text.toLowerCase());

        return activityMatch && locationMatch && genderMatch && typeMatch;
      }).toList();
    });
  }

  Map<String, int> getCounts(String column) {
    Map<String, int> counts = {};
    for (var entry in filteredData) {
      var key = entry[column].toString();
      if (counts.containsKey(key)) {
        counts[key] = (counts[key] ?? 0) + 1;
      } else {
        counts[key] = 1;
      }
    }
    return counts;
  }

  ListTile generateCountListTile(String title, Map<String, int> counts) {
    return ListTile(
      title: Text(title),
      subtitle: Text(counts.entries.map((e) => '${e.key}: ${e.value}').join(', ')),
    );
  }

  List<charts.Series<dynamic, String>> _createPieData(Map<String, int> dataMap) {
    return [
      charts.Series<String, String>(
        id: 'Counts',
        domainFn: (String type, _) => type,
        measureFn: (String type, _) => dataMap[type],
        data: dataMap.keys.toList(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> genderCounts = getCounts('Gender');
    Map<String, int> ageGroupCounts = getCounts('Age group');
    Map<String, int> typeCounts = getCounts('Type');

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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: activityController,
                  decoration: InputDecoration(labelText: 'Filter by Activity'),
                ),
                TextField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Filter by Location'),
                ),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: 'Filter by Gender'),
                ),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Filter by Type'),
                ),
                ElevatedButton(
                  child: Text('Apply Filters'),
                  onPressed: filterData,
                ),
              ],
            ),
          ),
          generateCountListTile('Activity Counts', getCounts('Activity')),
          generateCountListTile('Location Counts', getCounts('Location')),
          SizedBox(height: 20),
          Text('Gender Distribution', textAlign: TextAlign.center),
          Container(
            height: 200,
            child: charts.PieChart(_createPieData(genderCounts)),
          ),
          SizedBox(height: 10),
          generateCountListTile('Gender Counts', genderCounts),
          SizedBox(height: 20),
          Text('Age Group Distribution', textAlign: TextAlign.center),
          Container(
            height: 200,
            child: charts.PieChart(_createPieData(ageGroupCounts)),
          ),
          SizedBox(height: 10),
          generateCountListTile('Age Group Counts', ageGroupCounts),
          SizedBox(height: 20),
          Text('Type Distribution', textAlign: TextAlign.center),
          Container(
            height: 200,
            child: charts.PieChart(_createPieData(typeCounts)),
          ),
          SizedBox(height: 10),
          generateCountListTile('Type Counts', typeCounts),
        ],
      ),
    );
  }
}
