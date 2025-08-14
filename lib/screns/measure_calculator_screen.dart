import 'package:flutter/material.dart';
import '../models/calculator_model.dart';
import '../widgets/calculator_button.dart';
import 'calculator_screen.dart';
import 'scientific_calculator_screen.dart';

class MeasureCalculatorScreen extends StatefulWidget {
  const MeasureCalculatorScreen({super.key});

  @override
  State<MeasureCalculatorScreen> createState() => _MeasureCalculatorScreenState();
}

class _MeasureCalculatorScreenState extends State<MeasureCalculatorScreen> {
  final MeasureCalculatorModel _model = MeasureCalculatorModel();
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputController.text = '0';
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (_inputController.text == '0') {
        _inputController.text = number;
      } else {
        _inputController.text += number;
      }
      _model.setInputValue(_inputController.text);
    });
  }

  void _onClear() {
    setState(() {
      _inputController.text = '0';
      _model.setInputValue('0');
    });
  }

  void _onBackspace() {
    setState(() {
      if (_inputController.text.length > 1) {
        _inputController.text = _inputController.text.substring(0, _inputController.text.length - 1);
      } else {
        _inputController.text = '0';
      }
      _model.setInputValue(_inputController.text);
    });
  }

  void _onDecimal() {
    setState(() {
      if (!_inputController.text.contains('.')) {
        _inputController.text += '.';
        _model.setInputValue(_inputController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Icon(Icons.straighten),
      ),
      body: Column(
        children: [
          // Category Selector
          Container(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
              value: _model.currentCategory,
              dropdownColor: Colors.grey[900],
              style: const TextStyle(color: Colors.white, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.deepPurple,
              ),
              items: _model.getAvailableCategories().map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _model.setCategory(newValue);
                  });
                }
              },
            ),
          ),
          
          // Conversion Display
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Input Section
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _model.setInputValue(value);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _model.fromUnit,
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      underline: Container(),
                      items: _model.getAvailableUnits().map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _model.setFromUnit(newValue);
                          });
                        }
                      },
                    ),
                  ],
                ),
                
                const Icon(Icons.arrow_downward, color: Colors.deepPurple, size: 30),
                
                // Result Section
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _model.result.toStringAsFixed(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), ''),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _model.toUnit,
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      underline: Container(),
                      items: _model.getAvailableUnits().map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _model.setToUnit(newValue);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
                     // Number Pad
           Expanded(
             child: GridView.count(
               crossAxisCount: 3,
               padding: const EdgeInsets.all(12),
               mainAxisSpacing: 8,
               crossAxisSpacing: 8,
              children: [
                // Numbers 1-9
                for (int i = 1; i <= 9; i++)
                  CalculatorButton(
                    text: i.toString(),
                    onPressed: _onNumberPressed,
                    color: Colors.grey[700]!,
                  ),
                
                // Bottom row
                CalculatorButton(
                  text: 'C',
                  onPressed: (_) => _onClear(),
                  color: Colors.red,
                ),
                CalculatorButton(
                  text: '0',
                  onPressed: _onNumberPressed,
                  color: Colors.grey[700]!,
                ),
                CalculatorButton(
                  text: '⌫',
                  onPressed: (_) => _onBackspace(),
                  color: Colors.orange,
                ),
                
                // Decimal and Switch
                CalculatorButton(
                  text: '.',
                  onPressed: (_) => _onDecimal(),
                  color: Colors.grey[700]!,
                ),
                CalculatorButton(
                  text: 'SW',
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
                     if (choice == 'common') {
                       Navigator.of(context).pushReplacement(
                         MaterialPageRoute(
                           builder: (_) => const CalculatorScreen(),
                         ),
                       );
                     } else if (choice == 'scientific') {
                       Navigator.of(context).pushReplacement(
                         MaterialPageRoute(
                           builder: (_) => const ScientificCalculatorScreen(),
                         ),
                       );
                     }
                  },
                  color: Colors.deepPurple,
                ),
                const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
