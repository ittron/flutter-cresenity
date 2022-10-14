import 'package:flutter_cresenity/app/model/abstract_data_model.dart';

class GetInfoModel extends AbstractDataModel {
  String sessionId;
  String ipAddress;

  GetInfoModel.fromJson(Map map) {
    sessionId = map['sessionId'];
    ipAddress = map['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'ipAddress': ipAddress,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
