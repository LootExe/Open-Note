import 'package:flutter/material.dart';

class NoteMenuItem extends StatelessWidget {
  const NoteMenuItem({
    super.key,
    required this.icon,
    this.iconColor,
    required this.label,
  });

  final IconData icon;
  final Color? iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8.0),
        Expanded(child: Text(label)),
      ],
    );
  }
}
