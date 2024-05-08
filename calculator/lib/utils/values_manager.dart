bool isNumeric(String str) {
  if (str.isEmpty) {
    return false;
  }

  try {
    double.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}