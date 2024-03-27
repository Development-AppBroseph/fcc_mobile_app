import 'package:fcc_app_front/features/chat/data/models/message.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:fcc_app_front/shared/config/utils/get_token.dart';
import 'package:fcc_app_front/shared/constants/hive.dart';
import 'package:fcc_app_front/shared/constants/urls.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // getIt.registerSingleton<WebSocketChannel>(
  //   IOWebSocketChannel.connect(
  //     Uri.parse(socketUrl),
  //     headers: <String, String>{
  //       'Authorization': 'Bearer ${getToken()}',
  //       'Origin': baseUrl,
  //     },
  //   ),
  // );
}
