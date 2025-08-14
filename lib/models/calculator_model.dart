// lib/models/calculator_model.dart
import 'dart:math' as math;
class CalculatorModel {
  String _displayValue = '0';
  String _storedValue = '0';
  String _operation = '';
  bool _waitingForSecondOperand = false;
  final List<String> _history = [];

  String get displayValue => _displayValue;
  List<String> get history => List.unmodifiable(_history);
  void clearHistory() {
    _history.clear();
  }

  void handleButtonPress(String buttonText) {
    if (buttonText == 'C') {
      _clearAll();
    } else if (buttonText == '⌫') {
      _backspace();
    } else if (buttonText == '.') {
      _addDecimalPoint();
    } else if (buttonText == '=') {
      _performCalculation();
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      _setOperation(buttonText);
    } else {
      _inputDigit(buttonText);
    }
  }

  void _clearAll() {
    _displayValue = '0';
    _storedValue = '0';
    _operation = '';
    _waitingForSecondOperand = false;
  }

  void _backspace() {
    if (_displayValue.length == 1) {
      _displayValue = '0';
    } else {
      _displayValue = _displayValue.substring(0, _displayValue.length - 1);
    }
  }

  void _addDecimalPoint() {
    if (_waitingForSecondOperand) {
      _displayValue = '0.';
      _waitingForSecondOperand = false;
      return;
    }

    if (!_displayValue.contains('.')) {
      _displayValue += '.';
    }
  }

  void _inputDigit(String digit) {
    if (_waitingForSecondOperand) {
      _displayValue = digit;
      _waitingForSecondOperand = false;
    } else {
      _displayValue = _displayValue == '0' ? digit : _displayValue + digit;
    }
  }

  void _setOperation(String operation) {
    if (_operation.isNotEmpty && !_waitingForSecondOperand) {
      _performCalculation();
    }

    _storedValue = _displayValue;
    _operation = operation;
    _waitingForSecondOperand = true;
  }

  void _performCalculation() {
    if (_operation.isEmpty || _waitingForSecondOperand) {
      return;
    }

    double first = double.parse(_storedValue);
    double second = double.parse(_displayValue);
    double result = 0;

    switch (_operation) {
      case '+':
        result = first + second;
        break;
      case '-':
        result = first - second;
        break;
      case '×':
        result = first * second;
        break;
      case '÷':
        result = first / second;
        break;
      case '^':
        result = math.pow(first, second).toDouble();
        break;
    }

    String resultString = result.toString();
    if (resultString.endsWith('.0')) {
      resultString = resultString.substring(0, resultString.length - 2);
    }
    _history.add('$_storedValue $_operation $_displayValue = $resultString');
    _displayValue = resultString;

    _operation = '';
    _waitingForSecondOperand = false;
  }
}

class ScientificCalculatorModel extends CalculatorModel {
  void handleScientificButton(String buttonText) {
    if (buttonText == 'sin' || buttonText == 'cos' || buttonText == 'tan' || buttonText == 'log' || buttonText == 'ln') {
      _applyUnaryFunction(buttonText);
      return;
    }
    if (buttonText == '√') {
      _applySqrt();
      return;
    }
    if (buttonText == 'x²') {
      _applySquare();
      return;
    }
    if (buttonText == 'π') {
      _setConstant(3.1415926535897932);
      return;
    }
    if (buttonText == 'e') {
      _setConstant(2.718281828459045);
      return;
    }
    if (buttonText == '±') {
      _toggleSign();
      return;
    }
    if (buttonText == 'n!') {
      _applyFactorial();
      return;
    }
    if (buttonText == '^') {
      _setOperation('^');
      return;
    }
    if (buttonText == '%') {
      _applyPercent();
      return;
    }
    handleButtonPress(buttonText);
  }

  void _applyUnaryFunction(String fn) {
    final value = double.tryParse(displayValue) ?? 0.0;
    double result;
    switch (fn) {
      case 'sin':
        result = math.sin(_toRadians(value));
        break;
      case 'cos':
        result = math.cos(_toRadians(value));
        break;
      case 'tan':
        result = math.tan(_toRadians(value));
        break;
      case 'log':
        result = value <= 0 ? double.nan : math.log(value) / math.ln10;
        break;
      case 'ln':
        result = value <= 0 ? double.nan : math.log(value);
        break;
      default:
        result = value;
    }
    _setDisplay(result);
  }

  void _applySqrt() {
    final value = double.tryParse(displayValue) ?? 0.0;
    final result = value < 0 ? double.nan : math.sqrt(value);
    _setDisplay(result);
  }

  void _applySquare() {
    final value = double.tryParse(displayValue) ?? 0.0;
    _setDisplay(value * value);
  }

  void _applyFactorial() {
    final value = double.tryParse(displayValue) ?? 0.0;
    if (value < 0 || value.floorToDouble() != value) {
      _setDisplay(double.nan);
      return;
    }
    final int n = value.toInt();
    if (n > 170) {
      _setDisplay(double.infinity);
      return;
    }
    double result = 1.0;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    _setDisplay(result);
  }

  void _setConstant(double constant) {
    _setDisplay(constant);
  }

  void _toggleSign() {
    final value = double.tryParse(displayValue) ?? 0.0;
    _setDisplay(-value);
  }

  void _applyPercent() {
    final value = double.tryParse(displayValue) ?? 0.0;
    _setDisplay(value / 100.0);
  }

  void _setDisplay(double value) {
    var text = value.toString();
    if (text.endsWith('.0')) {
      text = text.substring(0, text.length - 2);
    }
    _displayValue = text;
    _waitingForSecondOperand = false;
  }

  double _toRadians(double deg) => deg * 3.1415926535897932 / 180.0;
}

class MeasureCalculatorModel extends CalculatorModel {
  String _currentCategory = 'Comprimento';
  String _fromUnit = 'm';
  String _toUnit = 'cm';
  double _inputValue = 0.0;
  double _result = 0.0;

  String get currentCategory => _currentCategory;
  String get fromUnit => _fromUnit;
  String get toUnit => _toUnit;
  double get inputValue => _inputValue;
  double get result => _result;

  final Map<String, Map<String, double>> _conversionFactors = {
    'Comprimento': {
      'mm': 0.001,
      'cm': 0.01,
      'm': 1.0,
      'km': 1000.0,
      'in': 0.0254,
      'ft': 0.3048,
      'yd': 0.9144,
      'mi': 1609.344,
    },
    'Peso': {
      'mg': 0.001,
      'g': 1.0,
      'kg': 1000.0,
      't': 1000000.0,
      'oz': 28.3495,
      'lb': 453.592,
    },
    'Volume': {
      'ml': 1.0,
      'l': 1000.0,
      'gal': 3785.41,
      'qt': 946.353,
      'pt': 473.176,
      'cup': 236.588,
    },
    'Temperatura': {
      'C': 0.0,
      'F': 0.0,
      'K': 0.0,
    },
  };

  void setCategory(String category) {
    _currentCategory = category;
    _updateDefaultUnits();
    _convert();
  }

  void setFromUnit(String unit) {
    _fromUnit = unit;
    _convert();
  }

  void setToUnit(String unit) {
    _toUnit = unit;
    _convert();
  }

  void setInputValue(String value) {
    _inputValue = double.tryParse(value) ?? 0.0;
    _convert();
  }

  void _updateDefaultUnits() {
    final units = _conversionFactors[_currentCategory]!.keys.toList();
    _fromUnit = units.first;
    _toUnit = units.length > 1 ? units[1] : units.first;
  }

  void _convert() {
    if (_currentCategory == 'Temperatura') {
      _convertTemperature();
    } else {
      _convertStandard();
    }
  }

  void _convertStandard() {
    final factors = _conversionFactors[_currentCategory]!;
    final fromFactor = factors[_fromUnit]!;
    final toFactor = factors[_toUnit]!;
    
    // Convert to base unit, then to target unit
    final baseValue = _inputValue * fromFactor;
    _result = baseValue / toFactor;
  }

  void _convertTemperature() {
    double celsius;
    
    // Convert to Celsius first
    switch (_fromUnit) {
      case 'C':
        celsius = _inputValue;
        break;
      case 'F':
        celsius = (_inputValue - 32) * 5 / 9;
        break;
      case 'K':
        celsius = _inputValue - 273.15;
        break;
      default:
        celsius = _inputValue;
    }
    
    // Convert from Celsius to target unit
    switch (_toUnit) {
      case 'C':
        _result = celsius;
        break;
      case 'F':
        _result = celsius * 9 / 5 + 32;
        break;
      case 'K':
        _result = celsius + 273.15;
        break;
      default:
        _result = celsius;
    }
  }

  List<String> getAvailableUnits() {
    return _conversionFactors[_currentCategory]!.keys.toList();
  }

  List<String> getAvailableCategories() {
    return _conversionFactors.keys.toList();
  }
}