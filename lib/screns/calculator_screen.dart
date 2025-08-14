// lib/screens/calculator_screen.dart
import 'package:flutter/material.dart';
import '../widgets/display.dart';
import '../widgets/calculator_button.dart';
import '../models/calculator_model.dart';
import '../utils/constants.dart';
import 'scientific_calculator_screen.dart';
import 'measure_calculator_screen.dart';

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
        automaticallyImplyLeading: false,
        title: IconButton(
          icon: const Icon(Icons.history),
          tooltip: 'Histórico',
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.grey[900],
              builder: (context) {
                final items = _model.history.reversed.toList();
                return SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'Histórico',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _model.clearHistory();
                              });
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            label: const Text('Limpar', style: TextStyle(color: Colors.redAccent)),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                      if (items.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Sem histórico ainda',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        )
                      else
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  items[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Display(value: _model.displayValue),
          const SizedBox(height: 20),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (var button in calculatorButtons)
                  if (button == 'SCI')
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
                                  ListTile(
                                    leading: const Icon(Icons.straighten, color: Colors.white),
                                    title: const Text('Medidas', style: TextStyle(color: Colors.white)),
                                    onTap: () => Navigator.pop(context, 'measure'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        if (!mounted) return;
                        if (choice == 'scientific') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ScientificCalculatorScreen(),
                            ),
                          );
                        } else if (choice == 'measure') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MeasureCalculatorScreen(),
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