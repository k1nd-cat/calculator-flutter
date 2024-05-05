class Result {
  double? _value;
  String? _error;

  Result({double? value, String? error}):
      _value = value,
      _error = error;

  double? get result => _value;
  String? get error => _error;

  Result _calculate(String? expression) {

    return Result(error: "Ошибка");
  }
}

