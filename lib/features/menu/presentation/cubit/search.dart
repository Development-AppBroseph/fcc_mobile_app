import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String?> {
  SearchCubit() : super(null);
  void search(String? query) async {
    emit(
      query?.trimRight(),
    );
  }
}
