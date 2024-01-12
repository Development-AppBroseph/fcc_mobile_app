import 'package:bloc/bloc.dart';

class EditingAddress extends Cubit<bool> {
  EditingAddress() : super(false);
  change(bool isChanging) async {
    emit(
      isChanging,
    );
  }
}
