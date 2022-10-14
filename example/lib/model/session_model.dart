import 'package:flutter_cresenity/app/model/abstract_data_model.dart';

class SessionModel extends AbstractDataModel {
  String sessionId;

  SessionModel.fromJson(Map map) {
    sessionId = map['sessionId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
