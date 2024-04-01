import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Assuming you have imported the necessary data from "alahliacademydata.dart"
// For demonstration purposes, I'm using a placeholder here
// import 'alahliacademydata.dart'; 

class AlahliAcademyStatistics extends StatelessWidget {
  final List<Map<String, dynamic>> players;

  AlahliAcademyStatistics({required this.players});

  Map<String, int> getCount(List<Map<String, dynamic>> data, String key) {
    Map<String, int> count = {};
    for (var item in data) {
      String? value = item[key];
      if (value != null && value != 'N/A') {
        if (count.containsKey(value)) {
          count[value] = (count[value] ?? 0) + 1;
        } else {
          count[value] = 1;
        }
      }
    }
    return count;
  }

  Color getBarColor(int index, int totalCount) {
    double hue = (360.0 * index) / totalCount;
    return HSLColor.fromAHSL(1.0, hue, 0.6, 0.7).toColor();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> nationalityCounts = getCount(players, 'Nationality');
    Map<String, int> positionCounts = getCount(players, 'Position'); // This is changed to 'Position'

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
                Text('التوزيع الإحصائي للمركز', style: TextStyle(fontSize: 18)), // Changed from 'التوزيع الإحصائي للمواسم' to 'التوزيع الإحصائي للمركز'
                SizedBox(height: 12.0),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: SideTitles(showTitles: false),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (BuildContext context, double value) => const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                          getTitles: (double value) {
                            return positionCounts.keys.elementAt(value.toInt()); // Using positionCounts instead of seasonCounts
                          },
                        ),
                      ),
                      barGroups: positionCounts.entries.toList().asMap().entries.map((mapEntry) { // Using positionCounts instead of seasonCounts
                        int index = mapEntry.key;
                        MapEntry<String, int> entry = mapEntry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              y: entry.value.toDouble(),
                              colors: [getBarColor(index, positionCounts.length)], // Using positionCounts instead of seasonCounts
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
