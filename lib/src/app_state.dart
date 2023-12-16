import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

//providerパッケージ(下位ツリーのWidgetから上位ツリーのWidgetが管理する状態にアクセスする手段を提供?)
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

// Firestoreにエントリを保存するコード
  Future<void> addHistoryToFirestore(int placeId, int duration) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('history')
        .add(<String, dynamic>{
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'placeId': placeId,
      'duration': duration,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    // return FirebaseFirestore.instance
    //     .collection('users') // コレクションID
    //     .doc('nishimi') // ドキュメントID
    //     .set({
    //   'timestamp': DateTime.now().millisecondsSinceEpoch,
    //   // 場所
    //   'placeId': 1,
    //   // 滞在時間
    //   'duration': 25,
    // }); //
  }
}
