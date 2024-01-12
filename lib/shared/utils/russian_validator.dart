bool russianValidator(String input) {
  final regExp = RegExp(r'^[А-Яа-яЁё ]+$');
  return regExp.hasMatch(input);
}
