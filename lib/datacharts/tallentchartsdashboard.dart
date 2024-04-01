import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TalentStatistics extends StatelessWidget {
  final List<Map<String, dynamic>> players;

  TalentStatistics({required this.players});

  Map<String, int> getCount(List<Map<String, dynamic>> data, String key) {
    Map<String, int> count = {};
    for (var item in data) {
      String? value = item[key];
      if (value != null && value != 'N/A') { // Filtering out 'N/A' values
        if (count.containsKey(value)) {
          count[value] = (count[value] ?? 0) + 1;
        } else {
          count[value] = 1;
        }
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> nationalityCounts = getCount(players, 'Nationality');
    Map<String, int> sportCounts = getCount(players, 'Sport');
    Map<String, int> teamCounts = getCount(players, 'Team'); // Get counts for Team column

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
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('إحصاءات الدول', style: TextStyle(fontSize: 18)),
                ...nationalityCounts.entries.map((entry) => ListTile(
                      title: Text(entry.key),
                      trailing: Text(entry.value.toString()),
                    )),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('إحصاءات الفرق', style: TextStyle(fontSize: 18)), // Team count display
                ...teamCounts.entries.map((entry) => ListTile(
                      title: Text(entry.key),
                      trailing: Text(entry.value.toString()),
                    )),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('التوزيع الإحصائي للرياضات', style: TextStyle(fontSize: 18)),
                SizedBox(height: 12.0),
                PieChart(
                  dataMap: sportCounts.map((key, value) => MapEntry(key, value.toDouble())),
                  animationDuration: Duration(milliseconds: 800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
