import 'package:bloc/bloc.dart';

import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';

class SelectedMembershipCubit extends Cubit<MembershipType?> {
  SelectedMembershipCubit() : super(null);
  change(MembershipType? type) {
    emit(
      type,
    );
  }
}
