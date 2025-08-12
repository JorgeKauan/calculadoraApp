// lib/screens/calculator_screen.dart
import 'package:flutter/material.dart';
import '../widgets/display.dart';
import '../widgets/calculator_button.dart';
import '../models/calculator_model.dart';
import '../utils/constants.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorModel _model = CalculatorModel();

  void _onButtonPressed(String buttonText) {
    setState(() {
      _model.handleButtonPress(buttonText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          Display(value: _model.displayValue),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (var button in calculatorButtons)
                  CalculatorButton(
                    text: button,
                    onPressed: _onButtonPressed,
                    color: _getButtonColor(button),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getButtonColor(String buttonText) {
    if (buttonText == 'C') {
      return Colors.red;
    } else if (buttonText == '=') {
      return Colors.green;
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      return Colors.blue;
    }
    return Colors.grey;
  }
}