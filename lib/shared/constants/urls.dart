import 'package:fcc_app_front/shared/config/utils/get_token.dart';

const String baseUrl = 'http://158.160.141.46:8081/';
String socketUrl = 'ws://158.160.141.46:8081/chat/admin/rooms/support/${getClientId()}';
const String inviteUrl = 'api/v1/users/check_invite_by_link?invite=';

//api/v1/users/memberships/
