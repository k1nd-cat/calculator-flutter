import 'package:calculator/controller/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Решение 3+4*2', () async {
    List<String> equation = ['3', '+', '4', '*', '2'];
    var result = Result(equation);
    double answer = 11;
    expect(answer, result.result);
  });

  test('Решение 3+4*2/(1-5)^2', () async {
    List<String> equation = ['3', '+', '4', '*', '2', '/', '(', '1', '-', '5', ')', '^', '2'];
    var result = Result(equation);
    double answer = 3.5;
    expect(answer, result.result);
  });

  test('Решение 3/0', () async {
    List<String> equation = ['3', '/', '0'];
    var result = Result(equation);
    String answer = "Произошла ошибка вычисления";
    expect(answer, result.error);
  });

  test('Решение 3*(1+2)', () async {
    List<String> equation = ['3', '*', '(', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 9;
    expect(answer, result.result);
  });

  test('Решение 3*(1+2', () async {
    List<String> equation = ['3', '*', '(', '1', '+', '2'];
    var result = Result(equation);
    double answer = 9;
    expect(answer, result.result);
  });

  test('Решение 3*(-1*1+2)', () async {
    List<String> equation = ['3', '*', '(', '-1', '*', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 3;
    expect(answer, result.result);
  });

  test('Решение 3-(-1*1+2)', () async {
    List<String> equation = ['3', '-', '(', '-1', '*', '1', '+', '2', ')'];
    var result = Result(equation);
    double answer = 2;
    expect(answer, result.result);
  });

  test('Решение 2+(3*4', () async {
    List<String> equation = ['2', '+', '(', '3', '*', '4'];
    var result = Result(equation);
    double answer = 14;
    expect(answer, result.result);
  });

  test('Решение 2(3+4', () async {
    List<String> equation = ['2', '(', '3', '+', '4'];
    var result = Result(equation);
    double answer = 14;
    expect(answer, result.result);
  });

  test('Решение 2(3+4)7', () async {
    List<String> equation = ['2', '(', '3', '+', '4', ')', '7'];
    var result = Result(equation);
    double answer = 98;
    expect(answer, result.result);
  });

  test('Решение 1+(1+2)(9-4)', () async {
    List<String> equation = ['1', '+', '(', '1', '+', '2', ')', '(', '9', '-', '4', ')'];
    var result = Result(equation);
    double answer = 16;
    expect(answer, result.result);
  });

  test('Решение 1+2(-16+3)^2-17.3=321.7', () async {
    List<String> equation = ['1', '+', '2', '(', '-16', '+', '3', ')', '^', '2', '-', '17.3'];
    var result = Result(equation);
    double answer = 321.7;
    expect(answer, result.result);
  });

  // test('Проверка решения уравнения', () async {
  //   List<String> equation = [''];
  //   var result = Result(equation);
  //   String answer = '';
  //   expect(answer, result.error);
  // });
}
