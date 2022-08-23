import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:mmt_club/API/api_links.dart';
import 'package:mmt_club/Models/Project/category_news_model.dart';
import 'package:mmt_club/Models/Project/complaint_model.dart';
import 'package:mmt_club/Models/Project/error.dart';
import 'package:mmt_club/Models/Project/home_model.dart';
import 'package:mmt_club/Models/Project/login_model.dart';
import 'package:mmt_club/Models/Project/notifications_model.dart';
import 'package:mmt_club/Models/Project/product_details_model.dart';
import 'package:mmt_club/Models/Project/profile_model.dart';
import 'package:mmt_club/bloc/notificationsBloc/notifications_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Project/category_model.dart';
import '../../Models/Project/general_settings_model.dart';
import '../../Models/Project/register_model.dart';
import '../statics.dart';

class Project {
  Project._();
  static final Project apiClient = Project._();

  Future<HomeModel> getHomeModel() async {
    String error;

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    //log(token.toString());
    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getHomePage),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        HomeModel homeModel =
            HomeModel.fromJson(jsonDecode(response.body)['result']);
        //print(homeModel.fullName!);

        return homeModel;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<List<CategoryModel>> getCategoriesModel() async {
    String error;

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    //log(token.toString());
    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getCategories),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        //print(json.decode(response.body)['result']);
        List<CategoryModel> cat = [];
        var data = json.decode(response.body)["result"];
        for (var item in data) {
          if (CategoryModel.fromJson(item).parentCategoryId == null) {
            cat.add(CategoryModel.fromJson(item));
          }
        }

        return cat;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<List<CategoryNewsModel>> getAllNews(int catID) async {
    //log(catID.toString());
    String error;
    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl +
            ApiLinks.getAllNewsByCategoryIdById +
            "?categoryId=$catID"),
        headers: {
          'Content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<CategoryNewsModel> news = [];
        var data = json.decode(response.body)["result"];
        for (var item in data) {
          news.add(CategoryNewsModel.fromJson(item));
        }

        return news;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<CategoryNewsModel> getNewsById(int newsId) async {
    String error;
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getNewsById + "?id=$newsId"),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)["result"];
        return CategoryNewsModel.fromJson(data);
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<List<ProductDetailsModel>> getAllProducts(
      {int? catID, String? keyWord}) async {
    String error;
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      String url = "";

      if (catID != null && keyWord != null) {
        url = url + "?categoryId=$catID&keyword=$keyWord";
      } else if (catID != null) {
        url = url + "?categoryId=$catID";
      } else if (keyWord != null) {
        url = url + "?keyword=$keyWord";
      }

      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getAllProduct + url),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<ProductDetailsModel> productDetailsModels = [];
        var data = json.decode(response.body)["result"];
        for (var item in data) {
          productDetailsModels.add(ProductDetailsModel.fromJson(item));
        }

        return productDetailsModels;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<ProfileModel> getProfileModel() async {
    String error;

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    //log(token.toString());
    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getProfile),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        //log(json.decode(response.body)['result']);
        ProfileModel profileModel =
            ProfileModel.fromJson(json.decode(response.body)['result']);
        //log(json.decode(response.body)['result']);

        return profileModel;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<GeneralSettingModel?> getGeneralSettingModel() async {
    String error;

    // final prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    //log(token.toString());
    try {
      final response = await Statics.httpClient.get(
        Uri.parse(Statics.baseUrl + ApiLinks.getGeneralSetting),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)["result"];
        GeneralSettingModel? generalSettingModel;
        if (data.isNotEmpty) {
          generalSettingModel = GeneralSettingModel.fromJson(data[0]);
        } else {
          generalSettingModel = null;
        }

        //log(json.decode(response.body)['result']);

        return generalSettingModel;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<String> login(String name) async {
    String error;
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    //String fcmToken = "";
    String fcmToken = await messaging.getToken().then((v) {
      return v ?? "";
    });

    LoginModel loginModel = LoginModel(name, name, fcmToken);
    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.login),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(loginModel.toJson()),
      );

      if (response.statusCode == 200) {
        //log(jsonDecode(response.body)['result']['accessToken'].toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token',
            jsonDecode(response.body)['result']['accessToken'].toString());
        await prefs.setString(
            'id', jsonDecode(response.body)['result']['userId'].toString());
        return "succss";
      } else {
        error = (jsonDecode(response.body))["error"]['message'];
        return error;
      }
    } on SocketException {
      return "check your internet connection";
    } on ClientException {
      return "check your internet connection";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> logout() async {
    String error;
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');

    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.logout + "?id=$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('id');

        return "succss";
      } else {
        error = (jsonDecode(response.body))["error"]['message'];
        return error;
      }
    } on SocketException {
      return "check your internet connection";
    } on ClientException {
      return "check your internet connection";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> register(String name) async {
    String error;
    RegisterModel registerModel = RegisterModel(name, name, name);
    //print(registerModel.toJson());
    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.register),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(registerModel.toJson()),
      );

      if (response.statusCode == 200) {
        await login(name);
        return "succss";
      } else {
        error = (jsonDecode(response.body))["error"]['message'];
        return error;
      }
    } on SocketException {
      return "check your internet connection";
    } on ClientException {
      return "check your internet connection";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<NotificationsModel>> getNotifications() async {
    String error;

    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('id');
    final String? token = prefs.getString('token');

    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.fcmNotification + "?id=$id"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: ' Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<NotificationsModel> notifications = [];
        var data = json.decode(response.body)["result"];
        for (var item in data) {
          notifications.add(NotificationsModel.fromJson(item));
        }

        return notifications;
      } else {
        error = (jsonDecode(response.body))["error"]['message'] as String;
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

  Future<String> complaint(ComplaintModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    //String error;
    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.complaint),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body:
            json.encode({"title": data.title, "description": data.description}),
      );

      if (response.statusCode == 200) {
        return "succss";
      } else {
        //error = (jsonDecode(response.body))["error"]['message']['details'];
        return "error";
      }
    } on SocketException {
      return "check your internet connection";
    } on ClientException {
      return "check your internet connection";
    } catch (e) {
      return e.toString();
    }
  }

  Future readQrcode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    try {
      final response = await Statics.httpClient.post(
        Uri.parse(Statics.baseUrl + ApiLinks.readQrcode + "?code=$code"),
        headers: {
          HttpHeaders.authorizationHeader: ' Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return "200";
      } else {
        ErrorModel errorModel =
            ErrorModel.fromJson((jsonDecode(response.body))["error"]);

        return errorModel;
      }
    } on SocketException {
      return "check your internet connection";
    } on ClientException {
      return "check your internet connection";
    } catch (e) {
      return e.toString();
    }
  }
}
