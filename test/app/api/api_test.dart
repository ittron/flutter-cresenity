import 'package:flutter_cresenity/app/model/abstract_data_model.dart';

class SessionModel extends AbstractDataModel {
  String sessionId;
  String expiredTime;

  SessionModel.fromJson(Map map) {
    sessionId = map['sessionId'];
    expiredTime = map['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'expiredTime': expiredTime,
    };
  }
}

void main() async {
  // await CF.init((Config config) {
  //   config.disableForConsole();
  // });
  // CF.model.registerBuilder(SessionModel, (map) {
  //   return SessionModel.fromJson(map);
  // });
  // String authId = 'a678803588713b45ae8baf50adefb813';
  // String url = 'http://tribelio.app.ittron.co.id/api/member/Login';
  // Map params = {'authId': authId};
  // ApiRequest sessionRequest = CF.api.createRequest(url, params);

/*
  test('Test response', () async {
    Response response = await sessionRequest.getResponse();
    expect(response != null, true);
    expect(response.body != null, true);
  });
  test('Test response model', () async {
    ResponseModel<SessionModel> responseModel =
        await sessionRequest.getResponseModel<SessionModel>();
    expect(responseModel != null, true);
    expect(responseModel.data != null, true);
    expect(responseModel.errCode, 0);
  });

  test('Test data model', () async {
    SessionModel sessionModel =
        await sessionRequest.getDataModel<SessionModel>();
    expect(sessionModel != null, true);
    expect(sessionModel.sessionId != null, true);
  });
*/
  // test('Test value notifier model', () async {
  //   SessionModel sessionModel = SessionModel.fromJson({});

  //   ValueNotifier<SessionModel> value = ValueNotifier(null);
  //   value.addListener(() {
  //     sessionModel = value.value;
  //   });
  //   await sessionRequest
  //       .bindTo<SessionModel>(value)
  //       .getDataModel<SessionModel>();
  //   expect(sessionModel != null, true);
  //   expect(sessionModel.sessionId != null, true);
  // });
}
