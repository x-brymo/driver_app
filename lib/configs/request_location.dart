import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class RequestLocation {
  Future<Position> getCurrentLocation() async {
    bool servicePermission = await Geolocator.isLocationServiceEnabled();
    if(!servicePermission) {
      log('service disable');
      return Future.error('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission(); 
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // desiredAccuracy: LocationAccuracy.high
    return await Geolocator.getCurrentPosition();
  }
}