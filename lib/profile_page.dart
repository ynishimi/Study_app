import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          ProfileCard(
            Icons.person,
            'nishimi',
          ),
          // firestoreのテスト
          ElevatedButton(
            child: Text('ウー'),
            onPressed: () async {
              print('ウー');
              await FirebaseFirestore.instance
                  .collection('users') // コレクションID
                  .doc('nishimi') // ドキュメントID
                  .set({'time': 'now', 'comment': 'ウー'}); // データ
            },
          ),
        ],
      ),
    );
  }
}
