import 'package:http/http.dart' show Client, Response;
import 'package:task/locator/locator.dart';

import 'api_links.dart';
export 'dart:convert';

class ApiCore {
  final apiClient = Client();
  final apiLinks = locator<ApiLinks>();
  Map<String, String> get authHeaders {
    return {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': 'application/json',
      'Authorization': 'Bearer Userid session',
    };
  }


  Map<String, String> get defaultHeaders {
    return {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept': 'application/json',
    };
  }

  void dispose() {
    apiClient.close();
  }
}
