// lib/models/calculator_model.dart
class CalculatorModel {
  String _displayValue = '0';
  String _storedValue = '0';
  String _operation = '';
  bool _waitingForSecondOperand = false;

  String get displayValue => _displayValue;

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
    }

    _displayValue = result.toString();
    if (_displayValue.endsWith('.0')) {
      _displayValue = _displayValue.substring(0, _displayValue.length - 2);
    }

    _operation = '';
    _waitingForSecondOperand = false;
  }
}