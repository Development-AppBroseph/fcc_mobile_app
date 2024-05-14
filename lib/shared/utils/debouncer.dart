import 'dart:async';

import 'package:fcc_app_front/export.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
