import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:routeapp/routes_dir/add_route.dart';
import 'package:routeapp/user_dir/user_profile.dart';
import 'package:photon/photon.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MapScreen());

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _searchText = '';
  MapController mapController = MapController();
  LatLng _currentLocation = LatLng(5.6037, -0.1870); // Accra, Ghana
  String _currentAddress = '';
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: _currentLocation,
          builder: (ctx) => Container(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 50.0,
            ),
          ),
        ),
      );
      _getAddressFromLatLng();
    });
  }

  void _getAddressFromLatLng() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLocation.latitude, _currentLocation.longitude);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      _currentAddress =
          '${placemark.subThoroughfare} ${placemark.thoroughfare}, '
          '${placemark.subLocality}, '
          '${placemark.locality}, '
          '${placemark.postalCode}, '
          '${placemark.country}';
    } else {
      _currentAddress = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenStreetMap Demo',
      home: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center:
                    _currentLocation, //LatLng(5.6037, -0.1870), // Accra, Ghana
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
            Positioned(
              top: 70.0,
              left: 10.0,
              right: 50.0,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) => UserProfileScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween(
                                begin: Offset(-1.0, 0.0),
                                end: Offset(0.0, 0.0),
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search Location',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                              onSubmitted: (value) async {
                                setState(() {
                                  _searchText = value;
                                });
                                List<Location> locations =
                                    await locationFromAddress(value);
                                // Use the first location in the list to center the map
                                if (locations.isNotEmpty) {
                                  Location location = locations.first;
                                  mapController.move(
                                      LatLng(location.latitude,
                                          location.longitude),
                                      13.0);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50.0,
              left: 100.0,
              right: 100.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRouteScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor: const Color.fromARGB(255, 0, 86, 79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(40, 15.0),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
