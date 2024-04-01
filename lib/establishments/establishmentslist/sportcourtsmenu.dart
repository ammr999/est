import 'package:flutter/material.dart';
import '../establishmentscharts/courtsstatistics.dart';
import '../establishmentsdata/courtsdata.dart';
import '../../constants.dart';



class SportCourtsMenu extends StatefulWidget {
  @override
  _SportCourtsMenuState createState() => _SportCourtsMenuState();
}

class _SportCourtsMenuState extends State<SportCourtsMenu> {
  final List<Map<String, dynamic>> courts = SportCourtData.sportCourtData;

  final TextEditingController typeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController activityController = TextEditingController();
  int selectedGymIndex = -1;

  @override
  void dispose() {
    typeController.dispose();
    categoryController.dispose();
    locationController.dispose();
    genderController.dispose();
    activityController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredData() {
    return courts.where((gym) {
      return (typeController.text.isEmpty || gym['Type'].toString().contains(typeController.text)) &&
          (categoryController.text.isEmpty || gym['Category'].toString().contains(categoryController.text)) &&
          (locationController.text.isEmpty || gym['Location'].toString().contains(locationController.text)) &&
          (genderController.text.isEmpty || gym['Gender'].toString().contains(genderController.text)) &&
          (activityController.text.isEmpty || gym['Activity'].toString().contains(activityController.text));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredData = getFilteredData();

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
          buildFilterTextField(typeController, 'Filter by Type'),
          buildFilterTextField(categoryController, 'Filter by Category'),
          buildFilterTextField(locationController, 'Filter by Location'),
          buildFilterTextField(genderController, 'Filter by Gender'),
          buildFilterTextField(activityController, 'Filter by Activity'),
          SizedBox(height: 10),
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
                          title: Text('Arabic Name: ${filteredData[index]['Arabic Name']}'),
                          subtitle: Text('Location: ${filteredData[index]['Location']}'),
                          trailing: Text('Activity: ${filteredData[index]['Activity']}'),
                        ),
                        if (selectedGymIndex == index) Divider(),
                        if (selectedGymIndex == index)
                          for (var entry in filteredData[index].entries)
                            if (entry.key != 'Arabic Name' && entry.key != 'Location' && entry.key != 'Activity')
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
                    MaterialPageRoute(builder: (context) => ChartsScreen(data: SportCourtData.sportCourtData)),
                  );
                },
                child: Text('تحليل'),
                backgroundColor: Color(0xFFf39c12), // Orange color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildFilterTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: (value) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
