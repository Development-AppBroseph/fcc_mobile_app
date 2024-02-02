/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsAvatarsGen {
  const $AssetsAvatarsGen();

  /// File path: assets/avatars/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/avatars/app_icon.png');

  /// File path: assets/avatars/fsc.svg
  SvgGenImage get fsc => const SvgGenImage('assets/avatars/fsc.svg');

  /// File path: assets/avatars/fsk.png
  AssetGenImage get fskPng => const AssetGenImage('assets/avatars/fsk.png');

  /// File path: assets/avatars/fsk.svg
  SvgGenImage get fskSvg => const SvgGenImage('assets/avatars/fsk.svg');

  /// File path: assets/avatars/logo-rounded.png
  AssetGenImage get logoRounded =>
      const AssetGenImage('assets/avatars/logo-rounded.png');

  /// File path: assets/avatars/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/avatars/logo.png');

  /// List of all assets
  List<dynamic> get values => [appIcon, fsc, fskPng, fskSvg, logoRounded, logo];
}

class $AssetsSettingsGen {
  const $AssetsSettingsGen();

  /// File path: assets/settings/about_us.svg
  SvgGenImage get aboutUs => const SvgGenImage('assets/settings/about_us.svg');

  /// File path: assets/settings/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/settings/chat.svg');

  /// File path: assets/settings/license_of_open_source_software.svg
  SvgGenImage get licenseOfOpenSourceSoftware =>
      const SvgGenImage('assets/settings/license_of_open_source_software.svg');

  /// File path: assets/settings/notif.svg
  SvgGenImage get notif => const SvgGenImage('assets/settings/notif.svg');

  /// File path: assets/settings/paper-clip.png
  AssetGenImage get paperClip =>
      const AssetGenImage('assets/settings/paper-clip.png');

  /// File path: assets/settings/person_plus.svg
  SvgGenImage get personPlus =>
      const SvgGenImage('assets/settings/person_plus.svg');

  /// File path: assets/settings/privacy_policy.svg
  SvgGenImage get privacyPolicy =>
      const SvgGenImage('assets/settings/privacy_policy.svg');

  /// File path: assets/settings/rate.svg
  SvgGenImage get rate => const SvgGenImage('assets/settings/rate.svg');

  /// File path: assets/settings/reboot.svg
  SvgGenImage get reboot => const SvgGenImage('assets/settings/reboot.svg');

  /// File path: assets/settings/send.png
  AssetGenImage get send => const AssetGenImage('assets/settings/send.png');

  /// File path: assets/settings/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/settings/settings.svg');

  /// File path: assets/settings/terms_of_use.svg
  SvgGenImage get termsOfUse =>
      const SvgGenImage('assets/settings/terms_of_use.svg');

  /// File path: assets/settings/version.svg
  SvgGenImage get version => const SvgGenImage('assets/settings/version.svg');

  /// List of all assets
  List<dynamic> get values => [
        aboutUs,
        chat,
        licenseOfOpenSourceSoftware,
        notif,
        paperClip,
        personPlus,
        privacyPolicy,
        rate,
        reboot,
        send,
        settings,
        termsOfUse,
        version
      ];
}

class Assets {
  Assets._();

  static const AssetGenImage appstore = AssetGenImage('assets/appstore.png');
  static const $AssetsAvatarsGen avatars = $AssetsAvatarsGen();
  static const SvgGenImage call = SvgGenImage('assets/call.svg');
  static const SvgGenImage car = SvgGenImage('assets/car.svg');
  static const AssetGenImage cart = AssetGenImage('assets/cart.png');
  static const SvgGenImage copy = SvgGenImage('assets/copy.svg');
  static const SvgGenImage delete = SvgGenImage('assets/delete.svg');
  static const SvgGenImage edit = SvgGenImage('assets/edit.svg');
  static const SvgGenImage file = SvgGenImage('assets/file.svg');
  static const AssetGenImage fsc = AssetGenImage('assets/fsc.png');
  static const SvgGenImage fscIcon = SvgGenImage('assets/fsc_icon.svg');
  static const SvgGenImage gift = SvgGenImage('assets/gift.svg');
  static const SvgGenImage home = SvgGenImage('assets/home.svg');
  static const SvgGenImage label = SvgGenImage('assets/label.svg');
  static const SvgGenImage logout = SvgGenImage('assets/logout.svg');
  static const SvgGenImage microphone = SvgGenImage('assets/microphone.svg');
  static const AssetGenImage offerPng = AssetGenImage('assets/offer.png');
  static const SvgGenImage offerSvg = SvgGenImage('assets/offer.svg');
  static const SvgGenImage person = SvgGenImage('assets/person.svg');
  static const AssetGenImage playstore = AssetGenImage('assets/playstore.png');
  static const AssetGenImage qrCode = AssetGenImage('assets/qr-code.png');
  static const SvgGenImage send = SvgGenImage('assets/send.svg');
  static const $AssetsSettingsGen settings = $AssetsSettingsGen();

  /// List of all assets
  static List<dynamic> get values => [
        appstore,
        call,
        car,
        cart,
        copy,
        delete,
        edit,
        file,
        fsc,
        fscIcon,
        gift,
        home,
        label,
        logout,
        microphone,
        offerPng,
        offerSvg,
        person,
        playstore,
        qrCode,
        send
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
