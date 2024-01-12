import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String?> {
  SearchCubit() : super(null);
  search(String? query) async {
    emit(
      query,
    );
  }
}
