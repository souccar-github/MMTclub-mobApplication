import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../Statics.dart';

class Project {
  Project._();
  static final Project apiClient = Project._();

  initLeaveBalance() async {
    String error;
    try {
      final response = await Statics.httpClient
          .get(Uri.parse(Statics.BaseUrl + "/api/"), headers: {
        HttpHeaders.authorizationHeader: '',
      });
      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error);
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
    return [];
  }

  Future addEntranceExitRequest() async {
    String error;
    try {
      final response =
          await Statics.httpClient.post(Uri.parse(Statics.BaseUrl + "/api/"),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: '',
              },
              body: jsonEncode(''));
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 401) {
        return Future.error("You are unauthorized !");
      } else {
        error = (jsonDecode(response.body))["Message"] as String;
        return Future.error(error);
      }
    } on SocketException {
      return Future.error("check your internet connection");
    } on ClientException {
      return Future.error("check your internet connection");
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
