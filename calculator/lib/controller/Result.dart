class Result {
  double? _value;
  String? _error;

  double? get result => _value;
  String? get error => _error;

  Result._internal({ double? value, String? error }) :
        _value = value,
        _error = error;

  factory Result(String? expression) {
    if (expression == null) return Result._internal();
    var ppn = _tStr2Ppn(expression);
    if (ppn == null) return Result._internal();
    return Result._internal(
      error: "Ошибка"
    );
  }

  static String? _tStr2Ppn(String expression) {
    return null;
  }
}

