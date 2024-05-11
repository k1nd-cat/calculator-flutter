import 'package:calculator/controller/result.dart';
import 'package:calculator/utils/values_manager.dart';

class InputManager {
  List<String> _equation = [];
  String _outputEquation = '';
  String? _outputResult = '';
  int _open = 0;

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

    _equation.forEach((element) => _outputEquation += element);
    _outputResult = Result(_equation).toString();
  }

  void _operationInput(String value) {
    if (_nextValue == 0 || _nextValue == 3) {
      _equation.add(value);
      _nextValue = 2;
    }
  }

  void _minusInput(String value) {
    if (_nextValue == 0) {
      _equation.add(value);
      _nextValue = 1;
    } else if (_nextValue == 3 && isNumeric(_equation.last)) {
      _equation.add(value);
      _nextValue = 1;
    }
  }

  void _pointInput() {
    if (_equation.isNotEmpty && isNumeric(_equation.last)) {
      _equation.last += '.';
    }

    _nextValue = 1;
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

  void _clearInput() {
    _equation.clear();
    _nextValue = 0;
  }

  void _openInput() {
    if (_nextValue == 0 || _nextValue == 2) {
      _equation.add('(');
      _open++;
      _nextValue = 0;
    }
  }

  void _closeInput() {
    if (_nextValue == 2 && _open > 0) {
      _equation.add(')');
      _open--;
      _nextValue = 2;
    }
  }

  void _digitInput(String value) {
    if (_nextValue == 0 || _nextValue == 1) {
      if (_equation.isNotEmpty && isNumeric(_equation.last)) {
        _equation.last += value;
      } else {
        _equation.add(value);
      }

      _nextValue = 3;
    }
  }
}
