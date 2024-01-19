import 'package:fcc_app_front/shared/config/routes.dart';

String bottomNavigationHandler(int index) {
  switch (index) {
    case 0:
      return RoutesNames.menu;
    case 1:
      return RoutesNames.profile;
    case 2:
      return RoutesNames.invite;
    case 3:
      return RoutesNames.order;
    default:
      return RoutesNames.menu;
  }
}
