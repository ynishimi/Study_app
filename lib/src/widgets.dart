import 'package:flutter/material.dart';

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
