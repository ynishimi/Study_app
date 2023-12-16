import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Location extends StatelessWidget {
  const Location(this.icon, this.title, this.subtitle, {super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.icon, this.name, {super.key});
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// 滞在履歴のカード
class HistoryCard extends StatelessWidget {
  const HistoryCard(this.timestamp, this.placeID, this.duration, {super.key});
  final Timestamp timestamp;
  final int placeID;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          '${duration.toString()} min',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        title: Text(
          placeID.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${timestamp.toDate()}',
        ),
      ),
    );
  }
}

// 履歴を確認するためのボタン
enum View { overview, detail }

class ViewChoice extends StatefulWidget {
  const ViewChoice({super.key});

  @override
  State<ViewChoice> createState() => _ViewChoiceState();
}

class _ViewChoiceState extends State<ViewChoice> {
  View view = View.detail;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<View>(
      segments: const <ButtonSegment<View>>[
        ButtonSegment<View>(
            value: View.overview,
            label: Text('Overview'),
            icon: Icon(Icons.calendar_view_month_rounded)),
        ButtonSegment<View>(
            value: View.detail,
            label: Text('Detail'),
            icon: Icon(Icons.calendar_view_day_rounded)),
      ],
      selected: <View>{view},
      onSelectionChanged: (Set<View> newSelection) {
        setState(() {
          view = newSelection.first;
        });
        HapticFeedback.selectionClick();
      },
    );
  }
}
