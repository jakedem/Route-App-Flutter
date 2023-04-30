import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:routeapp/routes_dir/location_service.dart';
import 'package:routeapp/routes_dir/get_current_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:routeapp/routes_dir/add_route.dart';
import 'package:routeapp/routes_dir/sidenav.dart';
import 'package:routeapp/user_dir/user_profile.dart';

class MapGoogle extends StatefulWidget {
  @override
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  static const LatLng _center = const LatLng(5.1200, -1.2907);

  String searchQuery = '';

  LatLng? _searchedLocation;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    // Get user's current location
    Position position = await LocationService.getCurrentLocation();

    // Move camera to user's current location
    LatLng latLng = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 12));

    // Add marker at center of map
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('user_location'),
          position: latLng,
        ),
      );
    });
  }

  void _searchLocation(String searchQuery) async {
    List<Location> locations = await locationFromAddress(searchQuery);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      LatLng searchedLatLng = LatLng(location.latitude, location.longitude);
      setState(() {
        _searchedLocation = searchedLatLng;
        _markers.add(
          Marker(
            markerId: MarkerId('searched_location'),
            position: searchedLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
        );
        if (_markers.length > 1) {
          _polylines.add(Polyline(
            polylineId: PolylineId('user_location_to_searched_location'),
            color: Colors.blue,
            width: 3,
            points: [_markers.first.position, searchedLatLng],
          ));
        }
      });
      mapController
          .animateCamera(CameraUpdate.newLatLngZoom(searchedLatLng, 12));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Sidebar(),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              markers: _markers,
              polylines: _polylines,
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0, 12, 0),
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        iconSize: 35.0,
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
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Location',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15.0),
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _searchLocation(searchQuery);
                            },
                          ),
                        ),
                        onChanged: (value) {
                          searchQuery = value;
                        },
                        onSubmitted: _searchLocation,
                      ),
                    ),
                  ],
                ),
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
