import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:routeapp/routes_dir/location_service.dart';
import 'package:routeapp/routes_dir/get_current_location.dart';
import 'package:geolocator/geolocator.dart';

class ParisMap extends StatefulWidget {
  @override
  _ParisMapState createState() => _ParisMapState();
}

class _ParisMapState extends State<ParisMap> {
  late GoogleMapController mapController;

  static const LatLng _center = const LatLng(5.1053, -1.2464);

  String searchQuery = '';

  //void _onMapCreated(GoogleMapController controller) {
  //mapController = controller;
  //}

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    // Get user's current location
    Position position = await LocationService.getCurrentLocation();

    // Move camera to user's current location
    LatLng latLng = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
  }

  void _searchLocation(String searchQuery) {
    searchLocationAndMoveCamera(searchQuery, mapController);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
            ),
            Positioned(
              top: 70,
              left: 50,
              right: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Location',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
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
            ),
          ],
        ),
      ),
    );
  }
}
