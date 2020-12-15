

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cresenity/type.dart';


class Utils {
  static ApplicationProfile getApplicationProfile() {
    if (kReleaseMode) {
      return ApplicationProfile.release;
    }
    if (kDebugMode) {
      return ApplicationProfile.debug;
    }
    if (kProfileMode) {
      return ApplicationProfile.profile;
    }

    ///Fallback
    return ApplicationProfile.debug;
  }

  /// Check if current platform is web
  static bool isWeb() => kIsWeb;

  /// Check if current platform is android
  static bool isAndroid() => Platform.isAndroid;

  /// Check if current platform is ios
  static bool isIos() => Platform.isIOS;


  static PlatformType getPlatformType() {
    if (isWeb()) {
      return PlatformType.Web;
    }
    if (isAndroid()) {
      return PlatformType.Android;
    }
    if (isIos()) {
      return PlatformType.iOS;
    }
    return PlatformType.Unknown;
  }

  static bool isCupertinoAppAncestor(BuildContext context) {
    return context.findAncestorWidgetOfExactType<CupertinoApp>() != null;
  }


}