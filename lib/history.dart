import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/widgets.dart';

// 履歴保存のウィジェット?
class History extends StatefulWidget {
  const History({
    super.key,
    required this.addHistory,
    required this.histories,
  });

  final FutureOr<void> Function(int placeId, int duration) addHistory;
  final List<EachHistory> histories;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          for (var eachHistory in widget.histories)
            // Text('${eachHistory.placeId}: ${eachHistory.duration}'),
            HistoryCard(
              eachHistory.timestamp,
              eachHistory.placeId,
              eachHistory.duration,
            ),
          const SizedBox(height: 8),
          ElevatedButton(
            child: Text('ウー'),
            onPressed: () async {
              // placeId, durationを取得してHistoryに追加する
              await widget.addHistory(_placeId, _duration);
            },
          ),
        ],
      ),
    );
  }
}

// 履歴の取得
class EachHistory {
  EachHistory(
      {required this.timestamp, required this.placeId, required this.duration});
  final Timestamp timestamp;
  final int placeId;
  final int duration;
}
