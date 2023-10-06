import 'package:flutter/material.dart';

class TileIcon extends StatelessWidget {
  const TileIcon({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(icon),
    );
  }
}
