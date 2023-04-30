import 'package:http/http.dart' as http;
import 'dart:convert';

class Routing {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  static Future<String> getRouteCoordinates(
      String apiKey, double lat1, double lng1, double lat2, double lng2) async {
    String url = '$_baseUrl'
        'origin=$lat1,$lng1'
        '&destination=$lat2,$lng2'
        '&key=$apiKey';

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> responseJson = json.decode(response.body);

    if (responseJson["status"] == "OK") {
      return responseJson["routes"][0]["overview_polyline"]["points"];
    } else {
      throw new Exception(responseJson["error_message"]);
    }
  }

  static Future<double> getDistance(
      String apiKey, double lat1, double lng1, double lat2, double lng2) async {
    String url = '$_baseUrl'
        'origin=$lat1,$lng1'
        '&destination=$lat2,$lng2'
        '&key=$apiKey';

    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> responseJson = json.decode(response.body);

    if (responseJson["status"] == "OK") {
      return responseJson["routes"][0]["legs"][0]["distance"]["value"] / 1000;
    } else {
      throw new Exception(responseJson["error_message"]);
    }
  }
}
