// lib/widgets/calculator_button.dart
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;
  final Color color;
  final IconData? icon;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.grey,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () => onPressed(text),
      child: icon == null
          ? Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          : Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
    );
  }
}