import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

import 'src/position.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Map<String, Marker> _markers = {};
  // 初期位置
  late LatLng _center = const LatLng(35.0262, 135.7808);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        double distance = locations.calcDistance(
            office.lat, office.lng, _center.latitude, _center.longitude);
        if (distance < 1000) {
          final marker = Marker(
            markerId: MarkerId(office.name),
            position: LatLng(office.lat, office.lng),
            infoWindow: InfoWindow(
              title: office.name,
              snippet: office.address,
            ),
          );
          _markers[office.name] = marker;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setCenterLocation(); // _centerを取得するメソッドを呼び出し
  }

  Future<void> _setCenterLocation() async {
    List<double> location = await getLocation(); // 位置情報を取得
    double latitude = location[0]; // 経度
    double longitude = location[1]; // 緯度
    debugPrint(latitude.toString());
    setState(() {
      _center = LatLng(latitude, longitude); // _centerを更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 4,
      ),
      markers: _markers.values.toSet(),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }
}
