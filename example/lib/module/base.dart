import 'package:example/api/api_service.dart';
import 'package:example/model/get_info_model.dart';
import 'package:example/model/session_model.dart';
import 'package:flutter_cresenity/cf.dart';
import 'package:flutter_cresenity/config/config.dart';
import 'package:flutter_cresenity/helper/utils.dart';
import 'package:flutter_cresenity/type.dart';

class Base {
  static init() async {
    await CF.init((Config config) {
      if (Utils.getApplicationProfile() != ApplicationProfile.release) {
        config.exception.addDeveloperPageReporter().addPrintReporter();
      }
    });

    CF.model.registerBuilderMany({
      SessionModel: (json) => SessionModel.fromJson(json),
      GetInfoModel: (json) => GetInfoModel.fromJson(json),
    });
  }

  static ApiService get api => ApiService.instance();
}
