// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.full});
  final double full;
  @override
  Widget build(BuildContext context) {
    final bool isdarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: full,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color:
                  isdarkmode
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
