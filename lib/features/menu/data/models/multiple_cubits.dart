import 'package:fcc_app_front/export.dart';

class MultipleCubits {
  MultipleCubits({
    required this.cubits,
  });
  final Map<String, Cubit<Equatable>> cubits;
}
