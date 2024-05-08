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
    List<String>? answer = null;
    expect(answer, result);
  });

  test('Проверка составления обратной польской записи', () async {
    List<String> equation = [')'];
    List<String>? result = Result.str2Ppn(equation);
    List<String>? answer = null;
    expect(answer, result);
  });
}
