import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavbarCont extends Cubit<int> {
  BottomNavbarCont() : super(0);
  dynamic change(int index) {
    emit(index);
  }
}
