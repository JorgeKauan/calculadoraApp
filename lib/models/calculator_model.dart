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