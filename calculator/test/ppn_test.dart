import 'package:calculator/controller/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Проверка составления обратной польской записи', () async {
    List<String> equation = ['3', '+', '4', '*', '2', '/', '(', '1', '-', '5', ')', '^', '2'];
    List<String> result = Result.str2Ppn(equation)!;
    List<String> answer = ['3', '4', '2', '*', '1', '5', '-', '2', '^', '/', '+'];
    expect(answer, result);
  });

  test('Проверка составления обратной польской записи', () async {
    List<String> equation = ['3', '+', '4', '*', '2'];
    List<String> result = Result.str2Ppn(equation)!;
    List<String> answer = ['3', '4', '2', '*', '+'];
    expect(answer, result);
  });

  test('Проверка составления обратной польской записи', () async {
    List<String> equation = [')'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer;
    expect(answer, result);
  });

  test('Проверка составления обратной польской записи', () async {
    List<String> equation = ['('];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = [];
    expect(answer, result);
  });

  test('Проверка решения уравнения', () async {
    List<String> equation = ['2', '+', '(', '3', '*', '4'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = ['2', '3', '4', '*', '+'];
    expect(answer, result);
  });

  test('Проверка решения уравнения', () async {
    List<String> equation = ['1', '+', '(', '1', '+', '2', ')', '(', '9', '-', '4', ')'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = ['1', '1', '2', '+', '9', '4', '-', '*', '+'];
    expect(answer, result);
  });

  test('Проверка решения уравнения', () async {
    List<String> equation = ['(', '1', '+', '2', ')'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = ['1', '2', '+'];
    expect(answer, result);
  });

  test('ОПЗ 1+2(-16+3)^2-17.3=321.7', () async {
    List<String> equation = ['1', '+', '2', '(', '-16', '+', '3', ')', '^', '2', '-', '17.3'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = ['1', '2', '-16', '3', '+', '2', '^', '*', '+', '17.3', '-'];
    expect(answer, result);
  });
}
