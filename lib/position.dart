import 'package:location/location.dart';

// 情報が取得可能か確認
Future<bool> checkLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }
  return true;
}

// // 情報取得
// Future<List<String>> getLocation() async {
//   Location location = Location();
//   LocationData locationData = await location.getLocation();
//   return [locationData.latitude.toString(), locationData.longitude.toString()];
// }
Future<List<double>> getLocation() async {
  Location location = Location();
  LocationData locationData = await location.getLocation();
  double lat = locationData.latitude ?? 0;
  double lon = locationData.longitude ?? 0;
  return [lat, lon];
}
