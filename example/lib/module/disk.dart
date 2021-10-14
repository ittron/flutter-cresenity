import 'package:flutter_cresenity/cf.dart';

class Disk {
  Disk._();
  static String getSessionId() {
    return get("sessionId");
  }

  static Future<void> setSessionId(String sessionId) async {
    await put("sessionId", sessionId);
  }

  static get(key) {
    return CF.storage.get(key);
  }

  static Future<bool> put(key, value) async {
    return await CF.storage.put(key, value);
  }
}
