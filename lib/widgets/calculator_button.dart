// lib/widgets/calculator_button.dart
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;
  final Color color;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: () => onPressed(text),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}