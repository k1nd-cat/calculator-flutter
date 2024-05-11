import 'package:calculator/utils/values_manager.dart';

class InputManager {
  List<String> _equation = [];
  String _outputEquation = '';
  String _outputResult = '';

  /**
   * nextValue code:
   * 0: only number || '-' || '('
   * 1: only number
   * 2: only number || '.'
   * 3:
   */
  int nextValue = 0;
  static final Map<String, String> _outputValues = {
    '+': '+',
    '-': '-',
    '*': '×',
    '/': '⨫',
    '^': '^'
  };

  List<String> get equation => _equation;
  String get outputEquation => _outputEquation;
  String get outputResult => _outputResult;

  void input(String value) {
    switch (value) {
      case '+':
      case '*':
      case '/':
      //     TODO: Logic method
        break;
      case '-':
      //     TODO: Logic method
        break;
      case '.':
        _pointInput();
        break;
      case '=':
      //    TODO: Logic method
        break;
      case '(':
      //   TODO Logic method
        break;
      case ')':
      //   TODO Logic method
        break;
      case '<':
      //   TODO Logic method
        break;
      case 'C':
      //   TODO Logic method
        break;
      default:
      //     TODO: Logic method
    }
  }

  void _pointInput() {
    if (_equation.isNotEmpty && isNumeric(_equation.last)) {
      _equation.last += '.';
    }
  }
}