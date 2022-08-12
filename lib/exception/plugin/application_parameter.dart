import 'package:flutter_cresenity/exception/exception_config.dart';
import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApplicationParameter implements Bootable {
  Map<String, dynamic> _applicationParameters = Map();

  Map<String, dynamic> get data => _applicationParameters;

  Future<void> boot() async {
    if (ExceptionConfig.instance().enableApplicationParameter) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _applicationParameters["version"] = packageInfo.version;
      _applicationParameters["appName"] = packageInfo.appName;
      _applicationParameters["buildNumber"] = packageInfo.buildNumber;
      _applicationParameters["packageName"] = packageInfo.packageName;
    }
  }
}
