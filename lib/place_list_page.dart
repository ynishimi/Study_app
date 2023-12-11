import 'package:flutter/material.dart';
import 'src/widgets.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key? key}) : super(key: key);

  @override
  _PlaceListState createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Location(Icons.place, '附属図書館', 'うー'),
          Location(Icons.place, '自習室24', 'ウー'),
        ],
      ),
    );
  }
}
