import 'dart:io';

import 'package:http/http.dart' as http;

import '../adapter.dart';
import '../request.dart';
import '../response.dart';

class HttpAdapter extends Adapter {
  Future<Response> request(Request request) async {

    var httpRequest = http.MultipartRequest(request.method.toUpperCase(), Uri.parse(request.url));

    request.paramCollection.asPostStringMap().forEach((key, value) {
      httpRequest.fields[key] = value;
    });

    await request.fileCollection.forEach((key, value) async {
      if (value != null) {
        // print('SN_LOG + IS FILE + ' + (value is File).toString());
        if (value is File) {
          // print('SN_LOG + IS EXIST + ' + value.existsSync().toString());
          if (value.existsSync()) {
//            String filePath = value.path;
//            String basename = path.basename(filePath);
//            var stream = new http.ByteStream(DelegatingStream.typed(value.openRead()));
//            var length = value.lengthSync();
//            http.MultipartFile multipartFile = new http.MultipartFile("$key", stream, length, filename: basename);
            http.MultipartFile multipartFile = await http.MultipartFile.fromPath('$key', value.path);
            httpRequest.files.add(multipartFile);
          }
        }
      }
    });

    var httpResponse = await httpRequest.send();
    String responseBody = await httpResponse.stream.bytesToString();


    Response response = Response(body: responseBody, statusCode: httpResponse.statusCode);

    return response;
  }
}
