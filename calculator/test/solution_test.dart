import 'package:calculator/controller/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Проверка решения уравнения: 3+4*2', () async {
    List<String> equation = ['3', '+', '4', '*', '2'];
    var result = Result(equation);
    double answer = 11;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 3+4*2/(1-5)^2', () async {
    List<String> equation = ['3', '+', '4', '*', '2', '/', '(', '1', '-', '5', ')', '^', '2'];
    var result = Result(equation);
    double answer = 3.5;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 3/0', () async {
    List<String> equation = ['3', '/', '0'];
    var result = Result(equation);
    String answer = "Произошла ошибка вычисления";
    expect(answer, result.error);
  });

  test('Проверка решения уравнения: 3*(1+2)', () async {
    List<String> equation = ['3', '*', '(', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 9;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 3*(1+2', () async {
    List<String> equation = ['3', '*', '(', '1', '+', '2'];
    var result = Result(equation);
    double answer = 9;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 3*(-1*1+2)', () async {
    List<String> equation = ['3', '*', '(', '-1', '*', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 3;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 3-(-1*1+2)', () async {
    List<String> equation = ['3', '-', '(', '-1', '*', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 2;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 2+(3*4', () async {
    List<String> equation = ['2', '+', '(', '3', '*', '4'];
    var result = Result(equation);
    double answer = 14;
    expect(answer, result.result);
  });

  test('Проверка решения уравнения: 2(3+4', () async {
    List<String> equation = ['2', '(', '3', '+', '4'];
    var result = Result(equation);
    double answer = 14;
    expect(answer, result.result);
  });

  // test('Проверка решения уравнения', () async {
  //   List<String> equation = [''];
  //   var result = Result(equation);
  //   String answer = '';
  //   expect(answer, result.error);
  // });
}
