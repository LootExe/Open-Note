import 'package:flutter/material.dart';

class NoteMenuItem extends StatelessWidget {
  const NoteMenuItem({
    required this.icon,
    required this.label,
    super.key,
    this.iconColor,
  });

  final IconData icon;
  final Color? iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    );
  }
}
