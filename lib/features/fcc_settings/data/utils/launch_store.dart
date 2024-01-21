import 'dart:io';

import 'package:fcc_app_front/export.dart';

dynamic launchStore({String? url}) {
  if (url != null) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } else if (Platform.isAndroid || Platform.isIOS) {
    //Todo: final appId = Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
    //Todo: Add your app url
    final Uri url = Uri.parse(
      Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=com.ashvaiberov.fscu'
          : 'https://apps.apple.com/app/%D1%84%D0%BA%D0%BA/id6469049914',
    );
    launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}

String getStoreLink() {
  return Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.ashvaiberov.fscu'
      : 'https://apps.apple.com/app/%D1%84%D0%BA%D0%BA/id6469049914';
}

dynamic launchWhatsapp() {
  launchUrl(
    Uri.parse(
      'https://wa.me/79851378350',
    ),
    mode: LaunchMode.externalApplication,
  );
}

dynamic launchTelegram() {
  launchUrl(
    Uri.parse(
      'https://t.me/Alina_Fyaritovna',
    ),
    mode: LaunchMode.externalApplication,
  );
}
