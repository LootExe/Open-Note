import 'package:flutter/material.dart';

class TileIcon extends StatelessWidget {
  const TileIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Icon(icon),
    );
  }
}
