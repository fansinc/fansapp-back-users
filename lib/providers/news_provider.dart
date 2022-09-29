import 'dart:convert';

import '/models/news_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class NewsProvider with ChangeNotifier {
  late String _tokenVal;

  List<NewsModel> newsModelList = [];

  Future<String?> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<List<NewsModel>> fetchSetNews() async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.newsUrl}';

      /*  final inputBodyVal = json.encode({
        "name": firstName + ' ' + lastName,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "mobile": mobile
      }); */

      final newsMapResponse = await get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        // body: inputBodyVal,
      );

      if (newsMapResponse.statusCode < 400) {
        final newsData =
            json.decode(newsMapResponse.body) as Map<String, dynamic>;
        newsData.forEach((key, value) {
          if (key == 'data') {
            newsModelList = [];
            //Map<String, dynamic> newsMap;
            for (int i = 0; i < value.length; i++) {
              newsModelList.add(
                NewsModel(
                  id: value[i]['id'],
                  description: value[i]['description'],
                  playerId: value[i]['player_id'],
                  playerName: value[i]['player_name'],
                  statusId: value[i]['status_id'],
                  statusName: value[i]['status_name'],
                  title: value[i]['title'],
                  image: value[i]['Assets']['data'][0]['links']['full'],
                  //['data'][0]['links']['full'],
                ),
              );
            }
          }
        });
        // print(newsModelList.toString());
        notifyListeners();
        return newsModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(newsMapResponse.body)['message'];
        //['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }

  Future<void> createNews(playerId, title, description, statusId, uUID) async {
    String? errorMessage;

    try {
      _tokenVal = (await getToken())!;
      const url = '${AppConfig.baseUrl}${AppConfig.newsUrl}';

      final inputBodyVal = json.encode({
        "player_id": playerId,
        "title": title,
        "description": description,
        "status_id": statusId,
        "uuid": uUID,
      });
      // print(url);
      final newsMapResponse = await post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api.v1+json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_tokenVal'
        },
        body: inputBodyVal,
      );

      if (newsMapResponse.statusCode < 400) {
        notifyListeners();
        // return newsModelList;
      } else {
        //print(json.decode(registerMapResponse.body));
        errorMessage = json.decode(newsMapResponse.body)['message'];
        //['errors'];
        // print(AppStrings.registrationFailed);
        throw Exception(errorMessage);
      }
    } catch (error) {
      throw Exception(errorMessage);
    }
  }
}
