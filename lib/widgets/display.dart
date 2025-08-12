// lib/widgets/display.dart
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String value;

  const Display({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}