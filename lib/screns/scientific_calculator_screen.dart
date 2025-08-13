import 'package:flutter/material.dart';
import '../widgets/display.dart';
import '../widgets/calculator_button.dart';
import '../models/calculator_model.dart';
import '../utils/constants.dart';
import 'calculator_screen.dart';

class ScientificCalculatorScreen extends StatefulWidget {
  const ScientificCalculatorScreen({super.key});

  @override
  State<ScientificCalculatorScreen> createState() => _ScientificCalculatorScreenState();
}

class _ScientificCalculatorScreenState extends State<ScientificCalculatorScreen> {
  final ScientificCalculatorModel _model = ScientificCalculatorModel();

  void _onButtonPressed(String buttonText) {
    setState(() {
      _model.handleScientificButton(buttonText);
    });
  }

  Color _getButtonColor(String buttonText) {
    if (buttonText == 'C') return Colors.red;
    if (buttonText == '=') return Colors.green;
    if (['+', '-', '×', '÷', '^'].contains(buttonText)) return Colors.blue;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Icon(Icons.calculate),
      ),
      body: Column(
        children: [
          Display(value: _model.displayValue),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 5,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (var button in scientificButtons)
                  if (button.isEmpty)
                    const SizedBox.shrink()
                  else if (button == 'SW')
                    CalculatorButton(
                      text: button,
                      icon: Icons.calculate,
                      onPressed: (_) async {
                        final choice = await showModalBottomSheet<String>(
                          context: context,
                          backgroundColor: Colors.grey[900],
                          builder: (context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.science, color: Colors.white),
                                    title: const Text('Científica', style: TextStyle(color: Colors.white)),
                                    onTap: () => Navigator.pop(context, 'scientific'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.calculate, color: Colors.white),
                                    title: const Text('Comum', style: TextStyle(color: Colors.white)),
                                    onTap: () => Navigator.pop(context, 'common'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        if (!mounted) return;
                        if (choice == 'common') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CalculatorScreen(),
                            ),
                          );
                        }
                      },
                      color: _getButtonColor(button),
                    )
                  else
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
}


