import 'dart:math';

import 'package:calculator/utils/values_manager.dart';
import 'package:meta/meta.dart';
import 'package:stack/stack.dart';

class Result {
  double? _result;
  String? _error;

  double? get result => _result;
  String? get error => _error;

  Result._internal({ double? result, String? error }) :
        _result = result,
        _error = error;

  factory Result(List<String>? expression) {
    if (expression == null) return Result._internal();
    var ppn = str2Ppn(expression);
    if (ppn == null) return Result._internal(error: "Выражение недописано");
    double? result = solution(ppn);
    if (result == null) return Result._internal(error: "Произошла ошибка вычисления");
    return Result._internal(result: result);
  }

  @visibleForTesting
  static double? solution(List<String> ppn) {
    Stack<double> values = Stack<double>();
    for (var element in ppn) {
      if (isNumeric(element)) {
        values.push(double.parse(element));
      } else {
        double a, b;
        try {
          b = values.pop();
          a = values.pop();
        } catch (e) {
          return null;
        }

        double? value = _doOperation(element, a, b);
        if (value == null) return value;
        values.push(value);
      }
    }

    return values.length > 1 || values.isEmpty ? null : values.pop();
  }

  @visibleForTesting
  static List<String>? str2Ppn(List<String> equation) {
    List<String> currentEquation = [...equation];
    List<String> rpl = [];
    Stack<String> operators = Stack<String>();
    int lastPriority = 0;
    int openCount = 0;

    String lastValue = '';
    for (int i = 0; i < currentEquation.length; ++i) {
      if (currentEquation[i] == '(') {
        openCount++;
        if (isNumeric(lastValue)) {
          currentEquation.insert(i++, '*');
        }
      } else if (currentEquation[i] == ')') {
        openCount--;
        if (i + 1 < currentEquation.length && (isNumeric(currentEquation[i + 1]) || currentEquation[i + 1] == '(')) {
          currentEquation.insert(i + 1, '*');
        }
      }

      lastValue = currentEquation[i];
    }

    if (openCount < 0) {
      return null;
    } else {
      for (int i = 0; i < openCount; ++i) {
        currentEquation.add(')');
        openCount--;
      }
    }

    if (!(isNumeric(currentEquation.last) || currentEquation.last == ')')) return null;
    for (var value in currentEquation) {
      if (isNumeric(value)) {
        rpl.add(value);
      } else if (value == '(') {
        // openCount++;
        operators.push(value);
        lastPriority = _getPriority(value);
      } else if (value == ')') {
        // if (--openCount < 0) return null;
        while(operators.top() != '(') {
          rpl.add(operators.pop());
        }
        operators.pop();
        lastPriority = operators.isNotEmpty ? _getPriority(operators.top()) : 0;
      } else {
        // if (lastPriority >= _getPriority(value) && operators.isNotEmpty && operators.top() != '(') {
        //   rpl.add(operators.pop());
        // }
        while (lastPriority >= _getPriority(value) && operators.isNotEmpty && operators.top() != '(') {
          rpl.add(operators.pop());
          lastPriority = operators.isNotEmpty ? _getPriority(operators.top()) : 0;
        }
        operators.push(value);
        lastPriority = _getPriority(value);
      }
    }

    while(operators.isNotEmpty) {
      if (operators.top() != '(') {
        rpl.add(operators.pop());
      } else {
        operators.pop();
      }
    }

    return rpl;
  }

  static double? _doOperation(String operator, double a, double b) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) return null;
        else return a / b;
      case '^':
        return pow(a, b).toDouble();
      default:
        return null;
    }
  }

  static int _getPriority(String value) {
    switch(value) {
      case '(':case ')':
      return 4;
      case '^':
        return 3;
      case '*':case '/':
      return 2;
      case '+':case '-':
      return 1;
      default:
        return 0;
    }
  }
}
