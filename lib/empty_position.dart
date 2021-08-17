import 'package:flutter/material.dart';

class EmptyPosition extends StatelessWidget {
  final int indexPosition;
  final Color color;
  final void Function(int) onTap;

  const EmptyPosition({
    required this.indexPosition,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(indexPosition);
      },
      child: Container(
        color: color,
      ),
    );
  }
}
