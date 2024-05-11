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

  /**
   * nextValue code:
   * 0: number || '-' || '('
   * 1: only number
   * 2: except '.'
   * 3: all
   */
  int _nextValue = 0;
  static final Map<String, String> _outputValues = {
    '+': '+',
    '-': '-',
    '*': '×',
    '/': '⨫',
    '^': '^'
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
    _equation.forEach((element) => _outputEquation += element);
    _outputResult = Result(_equation).result.toString();
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
    if (_openCount > 0 && isNumeric(_equation.last)) {
      _equation.add(')');
      _lastIsNumeric = false;
      _pointCountInNumeric = 0;
      _openCount--;
    }
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
    // TODO: Evaluate the equation and set the output result
  }

  void _backspaceInput() {
    if (_equation.isNotEmpty) {
      if (_equation.last.length > 1) {
        _equation.last = _equation.last.substring(0, _equation.last.length - 1);
      } else {
        _equation.removeLast();
      }
    }
  }
}
