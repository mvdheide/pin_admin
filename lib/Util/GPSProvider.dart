import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GPSProvider {
  static Future<List<Placemark>> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    // // return await Geolocator.getCurrentPosition();
    // Position pos = await Geolocator.getCurrentPosition();
    // final coordinates = new Coordinates(pos.latitude, pos.longitude);
    // return await Geocoder.local.findAddressesFromCoordinates(coordinates);
    Position position = await Geolocator.getCurrentPosition();
    return await placemarkFromCoordinates(
        position.latitude, position.longitude); //, "nl_NL");
  }
}
