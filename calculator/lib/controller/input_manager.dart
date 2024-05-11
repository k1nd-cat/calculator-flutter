import 'package:calculator/controller/result.dart';
import 'package:calculator/utils/values_manager.dart';

class InputManager {
  List<String> _equation = [];
  String currentNumber = '';
  String _outputEquation = '';
  String? _outputResult = '';
  int _openCount = 0;
  bool _lastIsNumeric = false;
  int _pointCountInNumeric = 0;

  static final Map<String, String> _outputValues = {
    '+': '+',
    '-': '-',
    '*': '×',
    '/': '⨫',
    '^': '^',
  };

  List<String> get equation => _equation;
  String get outputEquation => _outputEquation;
  String? get outputResult => _outputResult;

  void input(String value) {
    switch (value) {
      case '+':
      case '*':
      case '/':
      case '^':
        _operationInput(value);
        break;
      case '-':
        _minusInput(value);
        break;
      case '.':
        _pointInput();
        break;
      case '=':
        _equalInput();
        break;
      case '(':
        _openInput();
        break;
      case ')':
        _closeInput();
        break;
      case '<':
        _backspaceInput();
        break;
      case 'C':
        _clearInput();
        break;
      default:
        _digitInput(value);
    }

    _outputEquation = '';
    if (_equation.isNotEmpty) {
      _equation.forEach((element) {
        _outputEquation += _outputValues[element] != null ? _outputValues[element]! : element;
      });
      int numericCount = 0;
      _equation.forEach((element) { if (isNumeric(element)) numericCount++; });
      _outputResult = Result(_equation).result != null && numericCount > 1
          ? Result(_equation).result.toString()
          : '';
    } else {
      _outputResult = '';
    }
  }

  void _operationInput(String value) {
    if ((_lastIsNumeric && isNumeric(_equation.last)) || _equation.last == ')') {
      _equation.add(value);
      _pointCountInNumeric = 0;
      _lastIsNumeric = false;
    }
  }

  void _minusInput(String value) {
    if (_equation.isEmpty || _equation.last == '(') {
      _equation.add(value);
      _lastIsNumeric = true;
    } else {
      _operationInput(value);
    }
  }

  void _pointInput() {
    if (_lastIsNumeric && _pointCountInNumeric == 0 && _equation.last[_equation.last.length - 1] != '-') {
      _equation.last += '.';
      _pointCountInNumeric++;
    }
  }

  void _openInput() {
    _equation.add('(');
    _lastIsNumeric = false;
    _pointCountInNumeric = 0;
    _openCount++;
  }

  void _closeInput() {
    if (_openCount <= 0 || (!isNumeric(_equation.last) && !(_equation.last == ')'))) return;
    _equation.add(')');
    _lastIsNumeric = false;
    _pointCountInNumeric = 0;
    _openCount--;
  }

  void _digitInput(String value) {
    if (_lastIsNumeric) {
      _equation.last += value;
    } else {
      _equation.add(value);
      _lastIsNumeric = true;
    }
  }

  void _clearInput() {
    _equation.clear();
    _lastIsNumeric = false;
    _openCount = 0;
    _pointCountInNumeric = 0;
  }

  void _equalInput() {
    if (_equation.isEmpty) return;
    double? result = Result(_equation).result;
    if (result == null) return;
    _equation.clear();
    _equation.add(result.toString());
    _pointCountInNumeric = _equation.last.contains('.') ? 1 : 0;
    _openCount = 0;
  }

  void _backspaceInput() {
    if (_equation.isEmpty) return;
    if (_equation.last.length > 1) {
      _equation.last = _equation.last.substring(0, _equation.last.length - 1);
      _lastIsNumeric = true;
      _pointCountInNumeric = _equation.last.contains('.') ? 1 : 0;
    } else {
      var removed = _equation.last;
      _equation.removeLast();
      if (removed == '(') _openCount--;
      else if (removed == ')') _openCount++;

      if (_equation.isNotEmpty && isNumeric(_equation.last)) {
        _lastIsNumeric = true;
        _pointCountInNumeric = _equation.last.contains('.') ? 1 : 0;
      } else {
        _lastIsNumeric = false;
        _pointCountInNumeric = 0;
      }
    }
  }
}
