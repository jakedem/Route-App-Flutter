import 'package:flutter/material.dart';
import 'package:location/location.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({Key? key}) : super(key: key);

  @override
  _AddRouteScreenState createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  late TextEditingController _eventNameController;
  late TextEditingController _currentLocationController;
  late TextEditingController _destinationController;
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController();
    _currentLocationController = TextEditingController();
    _destinationController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _currentLocationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    try {
      LocationData currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
        _currentLocationController.text =
            "${_currentLocation!.latitude}, ${_currentLocation!.longitude}";
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 0, 86, 79),
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //toolbarHeight: 80.0,
            title: Text('Add Route'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Add Route',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Enter your aim of route and the location \nfor depature',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      labelText: 'Event Name',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _currentLocationController,
                    decoration: InputDecoration(
                      labelText: 'Current Location',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _destinationController,
                    decoration: InputDecoration(
                      labelText: 'Destination',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  //the add button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.add, size: 30.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 86, 79),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(5.0),
                        minimumSize: Size(30.0, 30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Upcoming Routes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 200),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add save functionality later
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 97, 86),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100.0, vertical: 15.0),
                        textStyle: const TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
