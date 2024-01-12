import 'package:bloc/bloc.dart';

import '../../../catalog/data/datasources/catalog.dart';

class SelectedMembershipCubit extends Cubit<MembershipType?> {
  SelectedMembershipCubit() : super(null);
  change(MembershipType? type) {
    emit(
      type,
    );
  }
}
