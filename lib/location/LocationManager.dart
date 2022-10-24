import 'package:geolocator/geolocator.dart';

class LocationManager {
  static Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
