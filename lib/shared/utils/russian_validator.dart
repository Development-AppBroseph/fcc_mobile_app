bool russianValidator(String input) {
  final RegExp regExp = RegExp(r'^[А-Яа-яЁё ]+$');
  return regExp.hasMatch(input);
}
