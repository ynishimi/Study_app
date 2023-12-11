import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

import 'home_page.dart';
import 'position.dart';

void main() {
  runApp(const StudyApp());
}

class StudyApp extends StatefulWidget {
  const StudyApp({Key? key}) : super(key: key);

  @override
  _StudyAppState createState() => _StudyAppState();
}

class _StudyAppState extends State<StudyApp> {
  final Map<String, Marker> _markers = {};
  // late GoogleMapController mapController;
  LatLng _center = const LatLng(35, 139);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
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

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hakka',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.red,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
          myLocationEnabled: true,
        ),
      ),
    );
  }
}

// class StudyApp extends StatelessWidget {
//   const StudyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hakka',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
//         useMaterial3: true,
//       ),
//       home: const HomePage(title: 'Hakka'),
//     );
//   }
// }
