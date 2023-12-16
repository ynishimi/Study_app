import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/widgets.dart';
import 'src/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

// import 'package:go_router/go_router.dart'; // new

import 'package:provider/provider.dart';

import 'src/app_state.dart';
import 'home_page.dart';

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
          const ProfileCard(
            Icons.person_rounded,
            'nishimi',
          ),

          // Login機能テスト
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ViewChoice(),
                Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: HistoryCard(123, 1, 12),
          ),
          // firestoreのテスト
          ElevatedButton(
            child: Text('ウー'),
            onPressed: () async {
              print('ウー');
              await FirebaseFirestore.instance
                  .collection('users') // コレクションID
                  .doc('nishimi') // ドキュメントID
                  .set({
                'timestamp': DateTime.now().millisecondsSinceEpoch,
                // 場所
                'placeID': 1,
                // 滞在時間
                'duration': 25,
              }); // データ
            },
          ),
        ],
      ),
    );
  }
}
