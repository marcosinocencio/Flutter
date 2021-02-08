import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyBRs9eMYjhl3n53echMO8IYcpP2MmYDYdA';

class LocationUtil {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    final response = await http.get(url);

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
