import 'package:get_it/get_it.dart';

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
