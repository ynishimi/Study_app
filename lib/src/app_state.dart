import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../firebase_options.dart';
import '../history.dart';

//providerパッケージ(下位ツリーのWidgetから上位ツリーのWidgetが管理する状態にアクセスする手段を提供?)
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  // 履歴を表示するため?
  StreamSubscription<QuerySnapshot>? _historySubscription;
  List<EachHistory> _histories = [];
  List<EachHistory> get histories => _histories;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _historySubscription = FirebaseFirestore.instance
            .collection('history')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _histories = [];
          for (final document in snapshot.docs) {
            _histories.add(
              EachHistory(
                  timestamp: document.data()['timestamp'],
                  placeId: document.data()['placeId'],
                  duration: document.data()['duration']),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _histories = [];
        _historySubscription?.cancel();
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
      // 'timestamp': DateTime.now().millisecondsSinceEpoch,
      'timestamp': DateTime.now(),
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
