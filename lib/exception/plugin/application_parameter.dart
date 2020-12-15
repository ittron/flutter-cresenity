



import 'package:flutter_cresenity/interface/bootable.dart';
import 'package:package_info/package_info.dart';

class ApplicationParameter implements Bootable{

  Map<String, dynamic> _applicationParameters = Map();


  Map<String, dynamic> get data => _applicationParameters;

  Future<void> boot() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _applicationParameters["version"] = packageInfo.version;
    _applicationParameters["appName"] = packageInfo.appName;
    _applicationParameters["buildNumber"] = packageInfo.buildNumber;
    _applicationParameters["packageName"] = packageInfo.packageName;

  }

}