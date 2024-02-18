import 'package:fcc_app_front/shared/config/utils/get_token.dart';

const String baseUrl = 'http://158.160.141.46/';
String socketUrl =
    'ws://158.160.141.46/chat/admin/rooms/support/${getClientId()}';
const String inviteUrl = 'api/v1/users/check_invite_by_link?invite=';
const String changeMyProfileDetailsEndpoint = 'api/v1/users/change-my-profile';
