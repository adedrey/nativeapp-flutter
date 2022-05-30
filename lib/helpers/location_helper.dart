import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyDqIrmIsbdfqmHzq4rYe8QAveCI_QcD2kQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitute, double longitutde}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitute,$longitutde&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitute,$longitutde&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]["formatted_address"];
  }
}
