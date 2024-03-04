import 'dart:async';

import 'package:uni_links/uni_links.dart';

class AppLinkService {
  StreamSubscription? _streamSubscription;
  final Function(String) callBack;

  AppLinkService({required this.callBack});

  Future<void> initURIHandler() async {
    final Uri? initialURI = await getInitialUri();
    callBack(initialURI.toString());
  }

  void incomingLinkHandler() {
    _streamSubscription = uriLinkStream.listen((Uri? uri) {
      callBack(uri.toString());
    });
  }
}
