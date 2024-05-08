import 'package:calculator/controller/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Проверка решения уравнения', () async {
    List<String> equation = ['3', '+', '4', '*', '2'];
    var result = Result(equation);
    double answer = 11;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения', () async {
    List<String> equation = ['3', '+', '4', '*', '2', '/', '(', '1', '-', '5', ')', '^', '2'];
    var result = Result(equation);
    double answer = 3.5;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения', () async {
    List<String> equation = ['3', '/', '0'];
    var result = Result(equation);
    String answer = "Произошла ошибка вычисления";
    expect(answer, result.error);
  });
}
