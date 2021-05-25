import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
    required this.routeDestination,
  }) : super(key: key);

  final Widget routeDestination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 400),
        openBuilder: (context, _) => routeDestination,
        closedShape: const CircleBorder(side: BorderSide.none),
        closedElevation: 0.0,
        closedColor: Colors.transparent,
        closedBuilder: (context, openContainer) => Icon(
          Icons.settings,
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      ),
    );
  }
}
