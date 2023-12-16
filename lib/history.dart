import 'dart:async';

import 'package:flutter/material.dart';

import 'src/widgets.dart';

// 履歴保存のウィジェット?
class History extends StatefulWidget {
  const History({required this.addHistory, super.key});

  final FutureOr<void> Function(int placeId, int duration) addHistory;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // final _formKey = GlobalKey<FormState>(debugLabel: '_HistoryState');
  // final _controller = TextEditingController();
  final int _placeId = 3;
  final int _duration = 45;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text('ウー'),
        onPressed: () async {
          // await FirebaseFirestore.instance
          //     .collection('users') // コレクションID
          //     .doc('nishimi') // ドキュメントID
          //     .set({
          //   'timestamp': DateTime.now().millisecondsSinceEpoch,
          //   // 場所
          //   'placeId': 1,
          //   // 滞在時間
          //   'duration': 25,
          // }); //

          // placeId, durationを取得してHistoryに追加する
          await widget.addHistory(_placeId, _duration);
          // if (_formKey.currentState!.validate()) {
          //   // await widget.addHistory(_controller.text);
          //   // _controller.clear();
          // }
        },
      ),
    );
  }
}
