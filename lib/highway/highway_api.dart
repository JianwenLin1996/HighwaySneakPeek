import 'dart:io';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> highwayImagesGet(String highway) async {
  var queryParameters = {'h': highway};
  var url =
      Uri.https('llm.gov.my', '/assets/ajax.vigroot.php', queryParameters);
  print(url);
  var response;
  try {
    response = await http.get(
      url,
    );
  } on SocketException {
    return {'status': '404', 'status_msg': 'Please connect to internet.'};
  }

  if (response.statusCode == 200) {
    print("Success");
    print(response.body);
    return {'status': '200', 'status_msg': response.body};
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {'status': response.statusCode, 'status_msg': response.body};
  }
}
