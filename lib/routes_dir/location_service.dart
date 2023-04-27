import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

Future<void> searchLocationAndMoveCamera(
  String searchQuery,
  GoogleMapController mapController,
) async {
  try {
    final List<Location> locations = await locationFromAddress(searchQuery);

    if (locations.isNotEmpty) {
      final LatLng searchedLocation =
          LatLng(locations.first.latitude, locations.first.longitude);
      await mapController
          .animateCamera(CameraUpdate.newLatLng(searchedLocation));
    } else {
      throw 'No results found for the given query';
    }
  } catch (e) {
    print('Error: $e');
  }
}
